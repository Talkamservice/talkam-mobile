import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/notifications/presentation/widgets/announcement_banner.dart';
import 'package:talkam/features/post/presentation/widgets/indicator.dart';

class AnnouncementsCarousel extends StatefulWidget {
  const AnnouncementsCarousel({super.key});

  @override
  State<AnnouncementsCarousel> createState() => _AnnouncementsCarouselState();
}

class _AnnouncementsCarouselState extends State<AnnouncementsCarousel> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsBloc, NotificationsState>(
      bloc: injector.get(),
      listener: (context, state) {},
      buildWhen: (previous, current) => current is GetAnnouncementsSuccessState,
      builder: (context, state) {
        if (state is GetAnnouncementsSuccessState) {

          if(state.response.data.isNotEmpty) {
            return Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 88.0,
                  padEnds: false,
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    selectedIndex = index;
                    setState(() {});
                  },
                ),
                items: state.response.data.map((a) {
                  return Builder(
                    builder: (BuildContext context) {
                      return  AnnouncementBanner(announcement: a,);
                    },
                  );
                }).toList(),
              ),
              if(state.response.data.length>1)
              Positioned(
                  right: 10,
                  bottom: 10,
                  child: Indicator(
                    seledtedIndex: selectedIndex,
                    items_count: state.response.data.length,
                  ))
            ],
          );
          }
        }
        return 0.verticalSpace;
      },
    );
  }
}
