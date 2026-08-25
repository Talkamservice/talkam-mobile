import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/booking/presentation/blocs/booking_cubit/booking_cubit.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/gen/assets.gen.dart';

class TherapistsListScreen extends StatefulWidget {
  const TherapistsListScreen({super.key});

  @override
  State<TherapistsListScreen> createState() => _TherapistsListScreenState();
}

class _TherapistsListScreenState extends State<TherapistsListScreen> {
  late final BookingCubit _cubit;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _sort = 'rating';

  @override
  void initState() {
    super.initState();
    _cubit = BookingCubit();
    _cubit.loadTherapists();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _cubit.loadTherapists(search: query, sort: _sort);
    });
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Pallets.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (ctx) => _FilterSheet(
        currentSort: _sort,
        onApply: (sort) {
          setState(() => _sort = sort);
          _cubit.loadTherapists(
            search: _searchController.text,
            sort: sort,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: Pallets.white,
        appBar: AppBar(
          backgroundColor: Pallets.white,
          elevation: 0,
          centerTitle: false,
          title: TextView(
            text: "Therapist",
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              10.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _searchController,
                      hint: "Find your specialist",
                      onChanged: _onSearchChanged,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(Assets.images.svgV2.searchIcon),
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  GestureDetector(
                    onTap: _showFilterSheet,
                    child: Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: Pallets.grey95.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Pallets.grey95),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.images.svgV2.preferenceHorizontal,
                          colorFilter: const ColorFilter.mode(
                              Pallets.grey60, BlendMode.srcIn),
                          width: 18.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Expanded(
                child: BlocBuilder<BookingCubit, BookingState>(
                  builder: (context, state) {
                    if (state.status == BookingStatus.loading &&
                        (state.therapists == null ||
                            state.therapists!.isEmpty)) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Pallets.blueBubbleColor,
                        ),
                      );
                    }
                    if (state.status == BookingStatus.error &&
                        (state.therapists == null ||
                            state.therapists!.isEmpty)) {
                      return AppErrorWidget(
                        message:
                            state.errorMessage ?? 'Failed to load therapists',
                        onTap: () => _cubit.loadTherapists(),
                      );
                    }
                    final therapists = (state.therapists ?? [])
                        .map((item) => TherapistModel.fromDirectoryItem(item))
                        .toList();
                    if (therapists.isEmpty) {
                      return Center(
                        child: TextView(
                          text: 'No therapists found',
                          fontSize: 15,
                          color: Pallets.grey,
                        ),
                      );
                    }
                    return RefreshIndicator(
                      color: Pallets.blueBubbleColor,
                      onRefresh: () => _cubit.loadTherapists(
                        search: _searchController.text,
                        sort: _sort,
                      ),
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: therapists.length,
                        separatorBuilder: (context, index) => 16.verticalSpace,
                        itemBuilder: (context, index) {
                          final therapist = therapists[index];
                          return _TherapistCard(
                            therapist: therapist,
                            onTapBook: () {
                              context.pushNamed(
                                PageUrl.therapistProfileScreen,
                                extra: int.tryParse(therapist.id) ?? 0,
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  final String currentSort;
  final ValueChanged<String> onApply;

  const _FilterSheet({required this.currentSort, required this.onApply});

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late String _sort;

  @override
  void initState() {
    super.initState();
    _sort = widget.currentSort;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Pallets.grey95,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          20.verticalSpace,
          TextView(
            text: 'Sort by',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
          ),
          12.verticalSpace,
          _SortOption(
              label: 'Rating',
              value: 'rating',
              selected: _sort,
              onTap: (v) => setState(() => _sort = v)),
          _SortOption(
              label: 'Price',
              value: 'price',
              selected: _sort,
              onTap: (v) => setState(() => _sort = v)),
          24.verticalSpace,
          CustomButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onApply(_sort);
            },
            text: 'Apply',
          ),
        ],
      ),
    );
  }
}

class _SortOption extends StatelessWidget {
  final String label;
  final String value;
  final String selected;
  final ValueChanged<String> onTap;

  const _SortOption({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == selected;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Pallets.blueBubbleColor.withValues(alpha: 0.08)
              : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:
                isSelected ? Pallets.blueBubbleColor : const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
                text: label,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Pallets.boldBlack),
            if (isSelected)
              Icon(Icons.check_circle,
                  color: Pallets.blueBubbleColor, size: 20.w),
          ],
        ),
      ),
    );
  }
}

class _TherapistCard extends StatelessWidget {
  final TherapistModel therapist;
  final VoidCallback onTapBook;

  const _TherapistCard({
    required this.therapist,
    required this.onTapBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Pallets.pollTrackColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: therapist.avatarUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: therapist.avatarUrl,
                        width: 50.w,
                        height: 50.w,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => _AvatarPlaceholder(
                            name: therapist.name, size: 50.w),
                      )
                    : _AvatarPlaceholder(name: therapist.name, size: 50.w),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: TextView(
                            text: therapist.name,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Pallets.boldBlack,
                          ),
                        ),
                        4.horizontalSpace,
                        if (therapist.isVerified)
                          SvgPicture.asset(
                            Assets.images.svgV2.checkmarkBadge,
                            width: 16.w,
                          ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TextView(
                            text: therapist.title,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Pallets.grey,
                          ),
                        ),
                        if (therapist.specialties.isNotEmpty) ...[
                          8.horizontalSpace,
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Pallets.yellow.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextView(
                              text: therapist.specialties.first,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: Pallets.yelloDarker,
                            ),
                          ),
                        ],
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ImageWidget(
                        imageUrl: Assets.images.svgV2.money03,
                        size: 24,
                      ),
                      4.horizontalSpace,
                      TextView(
                        text: "₦${therapist.pricePerSession.toInt()} / session",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Pallets.boldBlack,
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      ImageWidget(
                        imageUrl: Assets.images.svgV2.calendarInActive,
                        color: Pallets.blueBubbleColor,
                        size: 24,
                      ),
                      4.horizontalSpace,
                      TextView(
                        text: therapist.nextAvailableSlot,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Pallets.blueBubbleColor,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.images.svgV2.starFilled,
                    width: 14.w,
                    colorFilter:
                        const ColorFilter.mode(Pallets.yellow, BlendMode.srcIn),
                  ),
                  4.horizontalSpace,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${therapist.rating} ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: "(${therapist.reviewsCount} reviews)",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Pallets.grey35,
                          ),
                        ),
                      ],
                    ),
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              8.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: onTapBook,
                      child: const Text(
                        "Book Now",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Container(
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Pallets.grey95),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.images.svgV2.userSearch,
                        colorFilter: const ColorFilter.mode(
                            Pallets.grey60, BlendMode.srcIn),
                        width: 24.w,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  final String name;
  final double size;

  const _AvatarPlaceholder({required this.name, required this.size});

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFFEBF5FB),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            fontSize: size * 0.38,
            fontWeight: FontWeight.w700,
            color: Pallets.blueBubbleColor,
          ),
        ),
      ),
    );
  }
}
