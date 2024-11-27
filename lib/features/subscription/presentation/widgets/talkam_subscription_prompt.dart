import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/subscription/presentation/widgets/subscription_plan_card.dart';
import 'package:talkam/features/subscription/utils/subscription_helper.dart';

class TalkamSubscriptionPrompt extends StatelessWidget {
  const TalkamSubscriptionPrompt({super.key, this.tittle, this.padding, required this.onReturnFromSubscription});

  final String? tittle;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onReturnFromSubscription;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.subscriptionScreen).then(
          (value) {
            onReturnFromSubscription();
          },
        );
      },
      child: Container(
        padding: padding ?? const EdgeInsets.all(10),
        decoration: BoxDecoration(gradient: blueWhiteGradient),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: tittle ??
                      "You have used  ${SubscriptionHelper.usedAnonymousCount} your 5 free anonymous post and comments, to post anonymously "
                          "without limit, ",
                  style: GoogleFonts.nunito(color: Pallets.black, fontSize: 12)),
              TextSpan(
                  text: "upgrade to TalkAM plus today",
                  style: GoogleFonts.nunito(color: Pallets.blueBubbleColor, decoration: TextDecoration.underline, fontSize: 12))
            ])),
      ),
    );
  }
}
