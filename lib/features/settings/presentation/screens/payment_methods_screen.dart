import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/settings/data/models/payment_method.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';

/// Lists saved cards from `GET /user/payment-methods`. Card tokens are only
/// ever created server-side by passing `save_card=true` at booking
/// initiate-payment — there is no "add card" endpoint, so this screen is
/// list + delete only, matching the legacy app's card-row visual treatment
/// (rounded tinted row, masked number, brand mark, trailing action).
class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final bloc = SettingsBloc(injector.get(), injector.get());

  @override
  void initState() {
    super.initState();
    bloc.add(const SettingsEvent.getPaymentMethods());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void _confirmDelete(BuildContext context, PaymentMethod method) {
    CustomDialogs.showConfirmDialog(
      context,
      tittle: 'Remove card',
      message:
          'Remove the card ending in ${method.last4}? You can save a new card the next time you check out.',
      confirmButtonBgColor: Colors.red,
      onYes: () => bloc.add(SettingsEvent.deletePaymentMethod(method.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          deletePaymentMethodFailure: (error) => CustomDialogs.error(error),
          deletePaymentMethodSuccess: (_) =>
              bloc.add(const SettingsEvent.getPaymentMethods()),
        );
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            padding: EdgeInsets.all(0.0),
            tittleText: "Payment Methods",
            centerTile: false,
            showDivider: true,
          ),
          body: state.maybeWhen(
            orElse: () => Center(child: CustomDialogs.getLoading(size: 50)),
            getPaymentMethodsFailure: (error) => Center(
              child: TextView(
                text: error,
                fontSize: 14,
                color: Pallets.grey400,
                align: TextAlign.center,
              ),
            ),
            getPaymentMethodsSuccess: (methods) => methods.isEmpty
                ? const _EmptyPaymentMethods()
                : ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    itemCount: methods.length,
                    separatorBuilder: (_, __) => 12.verticalSpace,
                    itemBuilder: (context, index) => _PaymentMethodRow(
                      method: methods[index],
                      onDelete: () => _confirmDelete(context, methods[index]),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class _PaymentMethodRow extends StatelessWidget {
  const _PaymentMethodRow({required this.method, required this.onDelete});

  final PaymentMethod method;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallets.blueBubbleColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: method.brand,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Pallets.grey400,
                ),
                5.verticalSpace,
                Row(
                  children: [
                    TextView(
                      text: "•••• •••• •••• ${method.last4}",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    if (method.expiryLabel.isNotEmpty) ...[
                      16.horizontalSpace,
                      TextView(
                        text: method.expiryLabel,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey400,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          5.horizontalSpace,
          InkWell(
            onTap: onDelete,
            child: const Icon(Icons.delete_outline, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class _EmptyPaymentMethods extends StatelessWidget {
  const _EmptyPaymentMethods();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.credit_card_outlined,
                size: 40.w, color: Pallets.grey400),
            16.verticalSpace,
            const TextView(
              text: "No saved cards yet",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              align: TextAlign.center,
            ),
            8.verticalSpace,
            TextView(
              text:
                  "Choose to save your card the next time you pay for a session — it'll show up here.",
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Pallets.grey400,
              align: TextAlign.center,
              lineHeight: 1.4,
            ),
          ],
        ),
      ),
    );
  }
}
