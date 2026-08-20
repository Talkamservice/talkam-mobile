import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

// NOTE: this screen has no backing endpoint — the v2 API only exposes a
// single session's note (GET/POST /therapist/sessions/{id}/notes), not a
// searchable list across all of a therapist's notes. The mock rows below
// stay for layout reference; tapping one can't open a real note since there
// is no session id behind it. Real per-session notes are reachable from
// ClientDetailsScreen's session history instead.

class ClientNotesListScreen extends StatefulWidget {
  const ClientNotesListScreen({super.key});

  @override
  State<ClientNotesListScreen> createState() => _ClientNotesListScreenState();
}

class _ClientNotesListScreenState extends State<ClientNotesListScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _notesList = const [
    {
      "name": "Bhandari",
      "time": "10m ago",
      "preview": "It was an incredible match! The home team clinc...",
      "title": "Title",
      "content":
          "As your therapist, I'm dedicated to supporting you every step of the way on your journey toward well-being. Together, we'll take the time to explore your thoughts and feelings deeply, identify any challenges you may be facing, and develop personalized strategies to help you not just cope but truly thrive. Remember, this is a safe and confidential space where you can express yourself openly and honestly without judgment. I'm here to listen, guide, and empower you as we work toward your goals."
    },
    {
      "name": "Johnson",
      "time": "30m ago",
      "preview": "The conference was a huge success, with attend...",
      "title": "Session Summary",
      "content":
          "Client reported significant progress in anxiety management techniques practiced over the last week. Discussed sleep hygiene routines and cognitive reframing."
    },
    {
      "name": "Martinez",
      "time": "1h ago",
      "preview": "I just finished reading a fantastic book that kept...",
      "title": "Progress Notes",
      "content":
          "Focused on work stress strategies. Recommended mindfulness exercises during peak morning hours."
    },
    {
      "name": "Nguyen",
      "time": "2h ago",
      "preview": "The new restaurant downtown offers an amazin...",
      "title": "CBT Reflection",
      "content":
          "Reviewed mood log entries. Identified cognitive distortions around social interactions."
    },
    {
      "name": "Smith",
      "time": "3h ago",
      "preview": "Our team completed the project ahead of sched...",
      "title": "Initial Assessment",
      "content":
          "Initial baseline assessment completed. Established 4-week therapy goals focused on burnout prevention."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: const CustomAppBar(
        tittle: TextView(
          text: "Clients Notes",
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Pallets.boldBlack,
        ),
        centerTile: false,
      ),
      body: Column(
        children: [
          12.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomTextField(
              controller: _searchController,
              hint: "Search messages",
              prefixIcon: Icon(
                Icons.search,
                color: Pallets.grey400,
                size: 22.w,
              ),
            ),
          ),
          16.verticalSpace,
          Expanded(
            child: ListView.separated(
              itemCount: _notesList.length,
              separatorBuilder: (context, index) => 12.verticalSpace,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              itemBuilder: (context, index) {
                final item = _notesList[index];
                return InkWell(
                  onTap: () => CustomDialogs.showToast("Coming soon"),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                        14.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    text: item["name"]!,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Pallets.boldBlack,
                                  ),
                                  TextView(
                                    text: item["time"]!,
                                    fontSize: 13,
                                    color: Pallets.grey400,
                                  ),
                                ],
                              ),
                              4.verticalSpace,
                              TextView(
                                text: item["preview"]!,
                                fontSize: 13,
                                color: Pallets.grey400,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
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
