// Model for POST /user/bookings/:id/initiate-payment

class InitiatePaymentCustomer {
  final String email;
  final String name;

  const InitiatePaymentCustomer({required this.email, required this.name});

  factory InitiatePaymentCustomer.fromJson(Map<String, dynamic> json) =>
      InitiatePaymentCustomer(
        email: json['email'] as String,
        name: json['name'] as String,
      );
}

class InitiatePaymentData {
  final String reference;
  final String amount;
  final String currency;
  final InitiatePaymentCustomer customer;
  final Map<String, dynamic> meta;

  const InitiatePaymentData({
    required this.reference,
    required this.amount,
    required this.currency,
    required this.customer,
    required this.meta,
  });

  factory InitiatePaymentData.fromJson(Map<String, dynamic> json) =>
      InitiatePaymentData(
        reference: json['reference'] as String,
        amount: json['amount'] as String,
        currency: json['currency'] as String,
        customer: InitiatePaymentCustomer.fromJson(
            json['customer'] as Map<String, dynamic>),
        meta: Map<String, dynamic>.from(json['meta'] as Map? ?? {}),
      );

  num get numericAmount => num.tryParse(amount) ?? 0;
}
