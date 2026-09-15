import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/features/therapist/data/therapist_profile_store.dart';
import 'package:talkam/features/therapist/presentation/screens/tabs/therapist_about_tab.dart';

class TherapistProfileInfoTab extends StatefulWidget {
  const TherapistProfileInfoTab({super.key});

  @override
  State<TherapistProfileInfoTab> createState() => _TherapistProfileInfoTabState();
}

class _TherapistProfileInfoTabState extends State<TherapistProfileInfoTab> {
  @override
  void initState() {
    super.initState();
    // Only fetch if not already loaded or currently loading
    final currentStatus = TherapistProfileStore.instance.loadStatus.value;
    if (currentStatus == TherapistProfileLoadStatus.error ||
        currentStatus == TherapistProfileLoadStatus.unauthorized ||
        currentStatus == TherapistProfileLoadStatus.loading && TherapistProfileStore.instance.profile.value.id.isEmpty) {
      TherapistProfileStore.instance.fetchFromServer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TherapistProfileLoadStatus>(
      valueListenable: TherapistProfileStore.instance.loadStatus,
      builder: (context, status, _) {
        if (status == TherapistProfileLoadStatus.loaded) {
          return ValueListenableBuilder(
            valueListenable: TherapistProfileStore.instance.profile,
            builder: (context, therapist, _) {
              return TherapistAboutTab(
                therapist: therapist,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              );
            },
          );
        } else if (status == TherapistProfileLoadStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Text(
              "Couldn't load your profile.",
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
          );
        }
      },
    );
  }
}
