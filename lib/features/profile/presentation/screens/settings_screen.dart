import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/profile/data/models/settings_category.dart';
import 'package:talkam/gen/assets.gen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        padding: EdgeInsets.all(0.0),
        tittleText: "Settings",
        centerTile: false,
        showDivider: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 14.h, right: 16.w, left: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 34.w,
                    height: 34.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Pallets.borderGrey,
                    ),
                  ),
                  10.horizontalSpace,
                  TextView(
                    text: "u/97dbsa2",
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlackV2,
                  ),
                  const Spacer(),
                  Container(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(56),
                      border: Border.all(color: Pallets.borderGrey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageWidget(imageUrl: Assets.images.svgs.icPersonEdit),
                        4.horizontalSpace,
                        TextView(text: "Edit profile")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0.h),
              child: Container(
                height: 1,
                color: Pallets.borderGrey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
              child: _SettingItemTile(
                settingsCategory: contentSettings,
                key: Key(contentSettings.title),
              ),
            ),
            Container(
              height: 1,
              color: Pallets.borderGrey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              child: _SettingItemTile(
                settingsCategory: accountSettings,
                key: Key(accountSettings.title),
              ),
            ),
            Container(
              height: 1,
              color: Pallets.borderGrey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              child: _SettingItemTile(
                settingsCategory: aboutSettings,
                key: Key(aboutSettings.title),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 40.h),
              child: InkWell(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: "Delete account",
                      fontWeight: FontWeight.w600,
                      color: Pallets.boldRed,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 16.0,
                      color: Color(0xFF444444),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingItemTile extends StatelessWidget {
  final SettingsCategory settingsCategory;

  const _SettingItemTile({super.key, required this.settingsCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: settingsCategory.title,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        16.verticalSpace,
        for (int i = 0; i < settingsCategory.items.length; i++) ...[
          InkWell(
            onTap: () => settingsCategory.items[i].onTap(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: settingsCategory.items[i].title,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF444444),
                ),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 14.0,
                  color: Color(0xFF444444),
                )
              ],
            ),
          ),
          if (i == settingsCategory.items.length) const SizedBox.shrink() else 16.verticalSpace
        ]
      ],
    );
  }
}
