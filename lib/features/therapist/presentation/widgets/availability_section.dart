import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/section_label.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/time_format.dart';
import 'package:talkam/features/therapist/data/models/availability_slot.dart';

/// The therapist's recurring weekly availability, grouped by day.
///
/// Replaces the static "AVAILABLE SLOTS" chips in the design, which modelled
/// nothing a therapist could actually maintain.
class AvailabilitySection extends StatelessWidget {
  const AvailabilitySection({
    super.key,
    required this.availability,
    required this.onAdd,
    required this.onEdit,
    required this.onRemove,
    this.showRequiredError = false,
  });

  final WeeklyAvailability availability;
  final VoidCallback onAdd;
  final ValueChanged<AvailabilitySlot> onEdit;
  final ValueChanged<AvailabilitySlot> onRemove;

  /// Set once Save has been attempted with nothing configured.
  final bool showRequiredError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(child: SectionLabel("Available slots")),
            TextView(
              text: "+ Add",
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Pallets.blueBubbleColor,
              onTap: onAdd,
            ),
          ],
        ),
        12.verticalSpace,
        if (availability.isEmpty)
          _EmptyState(onAdd: onAdd)
        else
          for (final day in availability.populatedDays) ...[
            _DayGroup(
              day: day,
              slots: availability.slotsFor(day),
              onEdit: onEdit,
              onRemove: onRemove,
            ),
            12.verticalSpace,
          ],
        if (showRequiredError) ...[
          4.verticalSpace,
          TextView(
            text: "Add at least one weekly time range so clients can book you.",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Pallets.errorRed,
            lineHeight: 1.4,
          ),
        ],
      ],
    );
  }
}

class _DayGroup extends StatelessWidget {
  const _DayGroup({
    required this.day,
    required this.slots,
    required this.onEdit,
    required this.onRemove,
  });

  final Weekday day;
  final List<AvailabilitySlot> slots;
  final ValueChanged<AvailabilitySlot> onEdit;
  final ValueChanged<AvailabilitySlot> onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: day.label,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Pallets.boldBlackV2,
        ),
        8.verticalSpace,
        for (final slot in slots) ...[
          AvailabilitySlotRow(
            slot: slot,
            onTap: () => onEdit(slot),
            onRemove: () => onRemove(slot),
          ),
          8.verticalSpace,
        ],
      ],
    );
  }
}

/// One window: the range, its length, and a remove affordance.
///
/// Removal is immediate with no confirmation — nothing is committed until the
/// screen's Save, so backing out is already free.
class AvailabilitySlotRow extends StatelessWidget {
  const AvailabilitySlotRow({
    super.key,
    required this.slot,
    required this.onTap,
    required this.onRemove,
  });

  final AvailabilitySlot slot;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Pallets.surfaceMuted,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Pallets.grey90),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextView(
                  text: formatSlotRange(context, slot),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Pallets.boldBlackV2,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Pallets.blueBubbleColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: TextView(
                  text: formatDurationShort(slot.durationMinutes),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Pallets.blueBubbleColor,
                ),
              ),
              8.horizontalSpace,
              InkWell(
                onTap: onRemove,
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: Pallets.grey400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.infoSurface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Pallets.infoBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_month_outlined,
                  size: 18.sp, color: Pallets.blueBubbleColor),
              8.horizontalSpace,
              const TextView(
                text: "No availability set",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlackV2,
              ),
            ],
          ),
          6.verticalSpace,
          const TextView(
            text:
                "Clients can't book you until you add at least one weekly time range.",
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Pallets.slate500,
            lineHeight: 1.4,
          ),
          12.verticalSpace,
          TextView(
            text: "Add time range",
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Pallets.blueBubbleColor,
            onTap: onAdd,
          ),
        ],
      ),
    );
  }
}
