/// One saved card from `GET /user/payment-methods` (v2). The token itself is
/// never serialized — only enough to render and let the user delete it.
class PaymentMethod {
  const PaymentMethod({
    required this.id,
    required this.brand,
    required this.last4,
    this.expiryMonth,
    this.expiryYear,
  });

  final String id;
  final String brand;
  final String last4;
  final int? expiryMonth;
  final int? expiryYear;

  String get expiryLabel => (expiryMonth != null && expiryYear != null)
      ? '${expiryMonth!.toString().padLeft(2, '0')}/${(expiryYear! % 100).toString().padLeft(2, '0')}'
      : '';

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json['id'].toString(),
        brand: json['brand']?.toString() ?? 'Card',
        last4: json['last4']?.toString() ?? json['last_4']?.toString() ?? '',
        expiryMonth: json['expiry_month'] is int
            ? json['expiry_month']
            : int.tryParse(json['expiry_month']?.toString() ?? ''),
        expiryYear: json['expiry_year'] is int
            ? json['expiry_year']
            : int.tryParse(json['expiry_year']?.toString() ?? ''),
      );
}
