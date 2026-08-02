import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.actions,
    this.leading,
    this.tittle,
    this.tittleText,
    this.onBackPressed,
    this.elevation,
    this.bgColor,
    this.fgColor,
    this.height,
    this.canGoBack = true,
    this.centerTile = true,
    this.leadingWidth,
    this.padding,
    this.showDivider = false,
    this.titleAlign,
  });

  final List<Widget>? actions;
  final Widget? leading;
  final Widget? tittle;
  final String? tittleText;
  final double? elevation;
  final VoidCallback? onBackPressed;
  final Color? bgColor;
  final Color? fgColor;
  final double? height;
  final double? leadingWidth;
  final bool? canGoBack;
  final bool? centerTile;
  final EdgeInsets? padding;
  final bool showDivider;
  final TextAlign? titleAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        children: [
          AppBar(
            backgroundColor: bgColor ?? Colors.transparent,
            foregroundColor: fgColor,
            toolbarHeight: height,
            elevation: elevation ?? 0,
            centerTitle: centerTile,
            iconTheme:
                IconThemeData(color: fgColor ?? context.colorScheme.onSurface),
            surfaceTintColor: bgColor ?? Colors.transparent,
            titleTextStyle: GoogleFonts.sora(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface),
            leadingWidth: leadingWidth,
            leading: leading ??
                (canGoBack!
                    ? IconButton(
                        icon: Icon(Icons.arrow_back_ios_new,
                            color: fgColor ?? context.colorScheme.onSurface),
                        onPressed:
                            onBackPressed ?? () => Navigator.pop(context),
                      )
                    : 0.verticalSpace),
            title: tittle ??
                TextView(
                  text: tittleText ?? '',
                  fontSize: 16,
                  align: titleAlign,
                  fontWeight: FontWeight.w600,
                  style: GoogleFonts.plusJakartaSans(
                      // fontSize: 16,
                      color: fgColor ?? context.colorScheme.onSurface),
                ),
            actions: actions,
          ),
          if (showDivider)
            Container(
              height: 1,
              color: Pallets.borderGrey,
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? (showDivider ? kToolbarHeight + 1 : kToolbarHeight));
}
