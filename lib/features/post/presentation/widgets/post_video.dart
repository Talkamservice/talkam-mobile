import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/video_widget.dart';
import 'package:talkam/features/post/presentation/widgets/indicator.dart';

class PostVideo extends StatefulWidget {
  const PostVideo({Key? key, required this.videos, this.radius}) : super(key: key);

  final List<String> videos;
  final double? radius;

  @override
  _PostVideoState createState() => _PostVideoState();
}

class _PostVideoState extends State<PostVideo>  with AutomaticKeepAliveClientMixin{
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.videos.length,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(widget.radius??10),
                  child: VideoWidget(videoPath: widget.videos[index], videoType: VideoSourceType.network, height: 200, width: 1.sw));
            },
          ),
        ),
        if (widget.videos.length > 1)
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Center(
              child: Indicator(
                seledtedIndex: _selectedIndex,
                items_count: widget.videos.length,
              ),
            ),
          ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
