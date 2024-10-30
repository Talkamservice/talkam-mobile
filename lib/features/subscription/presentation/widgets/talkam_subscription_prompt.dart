import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/subscription/presentation/widgets/subscription_plan_card.dart';

class TalkamSubscriptionPrompt extends StatelessWidget {
  const TalkamSubscriptionPrompt({super.key, this.tittle,  this.padding});
 final String? tittle;
 final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(10),
      decoration: BoxDecoration(gradient: blueWhiteGradient),
      child: RichText(

        textAlign: TextAlign.center,
          text:  TextSpan(children: [
        TextSpan(text: tittle?? "You have used up your 5 free anonymous post, to post anonymously without limit, ", style: GoogleFonts.nunito(color: Pallets
            .black,
            fontSize: 12)),
            TextSpan(text: "upgrade to TalkAM plus today",style: GoogleFonts.nunito(color: Pallets.blueBubbleColor,decoration: TextDecoration.underline,
                fontSize: 12))
      ])),
    );
  }
}
