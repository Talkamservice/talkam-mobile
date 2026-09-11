import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

/// A short static list for the demo bank picker — there's no backend
/// endpoint yet for managing payout details after onboarding (the real
/// `GET /therapist/banks` list is onboarding-only), so this stays local.
const List<String> _kDemoBanks = [
  "Access Bank",
  "Fidelity Bank",
  "First Bank of Nigeria",
  "Guaranty Trust Bank",
  "Kuda Bank",
  "Moniepoint",
  "Opay",
  "Polaris Bank",
  "Stanbic IBTC Bank",
  "Sterling Bank",
  "Union Bank",
  "United Bank for Africa",
  "Wema Bank",
  "Zenith Bank",
];

/// Manages the therapist's payout account.
///
/// **Demo state only** — no backend endpoint exists yet for reading or
/// saving a payout account after onboarding (the one real endpoint,
/// `POST /therapist/application/payout`, is onboarding-only). Everything
/// here lives in local widget state for the session, styled to match the
/// intended real flow (`TherapistPayoutScreen`) so it's ready to wire up
/// once the backend exists.
class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  String? _accountName;
  String? _accountNumber;
  String? _bankName;

  bool get _hasDetails =>
      _accountName != null && _accountNumber != null && _bankName != null;

  Future<void> _showEditSheet() async {
    final result = await CustomDialogs.showBottomSheet<_BankDetailsDraft>(
      context,
      _EditBankDetailsSheet(
        initialAccountName: _accountName ?? '',
        initialAccountNumber: _accountNumber ?? '',
        initialBankName: _bankName,
      ),
      constraints: BoxConstraints(maxHeight: 0.85.sh),
    );
    if (result == null || !mounted) return;
    setState(() {
      _accountName = result.accountName;
      _accountNumber = result.accountNumber;
      _bankName = result.bankName;
    });
    CustomDialogs.success("Bank details saved");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: const CustomAppBar(
        padding: EdgeInsets.all(0.0),
        tittleText: "Bank Details",
        centerTile: false,
        showDivider: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: _hasDetails
                    ? "Payouts are sent to this account."
                    : "Add the account you'd like session payouts sent to.",
                color: Pallets.grey400,
                fontSize: 14,
                lineHeight: 1.4,
              ),
              24.verticalSpace,
              if (_hasDetails) ...[
                _DetailCard(
                  bankName: _bankName!,
                  accountNumber: _accountNumber!,
                  accountName: _accountName!,
                ),
              ] else
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 72.w,
                          height: 72.w,
                          decoration: BoxDecoration(
                            color: Pallets.iconSurface,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.account_balance_outlined,
                            size: 32.sp,
                            color: Pallets.blueBubbleColor,
                          ),
                        ),
                        16.verticalSpace,
                        const TextView(
                          text: "No payout account yet",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Pallets.boldBlackV2,
                        ),
                      ],
                    ),
                  ),
                ),
              if (_hasDetails) const Spacer(),
              CustomButton(
                elevation: 0,
                onPressed: _showEditSheet,
                bgColor: Pallets.blueBubbleColor,
                borderRadius: BorderRadius.circular(12.r),
                child: TextView(
                  text: _hasDetails ? "Edit Details" : "Add Bank Details",
                  color: Pallets.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
  });

  final String bankName;
  final String accountNumber;
  final String accountName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.bgLight,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Pallets.iconSurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_outlined,
                  size: 20.w,
                  color: Pallets.blueBubbleColor,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: TextView(
                  text: bankName,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          const Divider(height: 1, color: Pallets.grey90),
          16.verticalSpace,
          _DetailRow(label: "Account Number", value: accountNumber),
          12.verticalSpace,
          _DetailRow(label: "Account Name", value: accountName),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextView(
          text: label,
          color: Pallets.grey400,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        TextView(
          text: value,
          color: Pallets.boldBlackV2,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ],
    );
  }
}

class _BankDetailsDraft {
  const _BankDetailsDraft({
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  });

  final String accountName;
  final String accountNumber;
  final String bankName;
}

class _EditBankDetailsSheet extends StatefulWidget {
  final String initialAccountName;
  final String initialAccountNumber;
  final String? initialBankName;

  const _EditBankDetailsSheet({
    required this.initialAccountName,
    required this.initialAccountNumber,
    required this.initialBankName,
  });

  @override
  State<_EditBankDetailsSheet> createState() => _EditBankDetailsSheetState();
}

class _EditBankDetailsSheetState extends State<_EditBankDetailsSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _numberController;
  String? _bankName;

  bool _accountNumberTouched = false;

  bool get _isAccountNumberValid =>
      _numberController.text.length == 10 &&
      int.tryParse(_numberController.text) != null;

  bool get _isValid =>
      _bankName != null &&
      _isAccountNumberValid &&
      _nameController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialAccountName);
    _numberController =
        TextEditingController(text: widget.initialAccountNumber);
    _bankName = widget.initialBankName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  Future<void> _pickBank() async {
    final bank = await CustomDialogs.showBottomSheet<String>(
      context,
      _SelectBankSheet(selected: _bankName),
    );
    if (bank != null) setState(() => _bankName = bank);
  }

  void _save() {
    Navigator.of(context).pop(_BankDetailsDraft(
      accountName: _nameController.text.trim(),
      accountNumber: _numberController.text.trim(),
      bankName: _bankName!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 24.h,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 24.h,
      ),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextView(
                  text: "Edit Bank Details",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: Pallets.grey, size: 22.w),
                ),
              ],
            ),
            24.verticalSpace,
            const TextView(
              text: "Bank",
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            8.verticalSpace,
            InkWell(
              onTap: _pickBank,
              child: AbsorbPointer(
                child: CustomTextField(
                  hint: "Select your bank",
                  controller: TextEditingController(text: _bankName ?? ''),
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                ),
              ),
            ),
            16.verticalSpace,
            const TextView(
              text: "Account Number",
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            8.verticalSpace,
            CustomTextField(
              controller: _numberController,
              hint: "Enter your 10-digit account number",
              keyboardType: TextInputType.number,
              forceError: _accountNumberTouched && !_isAccountNumberValid,
              forceValid: _accountNumberTouched && _isAccountNumberValid,
              onChanged: (v) => setState(() => _accountNumberTouched = true),
            ),
            if (_accountNumberTouched && !_isAccountNumberValid) ...[
              6.verticalSpace,
              const TextView(
                text: "Enter a valid 10-digit account number",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Pallets.errorRed,
              ),
            ],
            16.verticalSpace,
            const TextView(
              text: "Account Name",
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            8.verticalSpace,
            CustomTextField(
              controller: _nameController,
              hint: "Enter account name",
              onChanged: (_) => setState(() {}),
            ),
            32.verticalSpace,
            CustomButton(
              elevation: 0,
              onPressed: _isValid ? _save : null,
              bgColor: Pallets.blueBubbleColor,
              borderRadius: BorderRadius.circular(12.r),
              child: const TextView(
                text: "Save Details",
                color: Pallets.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectBankSheet extends StatefulWidget {
  const _SelectBankSheet({this.selected});

  final String? selected;

  @override
  State<_SelectBankSheet> createState() => _SelectBankSheetState();
}

class _SelectBankSheetState extends State<_SelectBankSheet> {
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final banks = _query.isEmpty
        ? _kDemoBanks
        : _kDemoBanks
            .where((b) => b.toLowerCase().contains(_query.toLowerCase()))
            .toList();

    return Container(
      height: 0.7.sh,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextView(
            text: "Select your bank",
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          12.verticalSpace,
          CustomTextField(
            hint: "Search bank",
            prefixIcon: const Icon(Icons.search),
            onChanged: (query) => setState(() => _query = query),
          ),
          12.verticalSpace,
          Expanded(
            child: banks.isEmpty
                ? const Center(child: TextView(text: "No banks found"))
                : ListView.separated(
                    itemCount: banks.length,
                    separatorBuilder: (_, __) =>
                        Divider(height: 1, color: Pallets.grey90),
                    itemBuilder: (context, index) {
                      final bank = banks[index];
                      final isSelected = bank == widget.selected;
                      return InkWell(
                        onTap: () => Navigator.of(context).pop(bank),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextView(
                                  text: bank,
                                  fontSize: 15,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? Pallets.blueBubbleColor
                                      : Pallets.boldBlackV2,
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check_circle,
                                    color: Pallets.blueBubbleColor,
                                    size: 20.w),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
