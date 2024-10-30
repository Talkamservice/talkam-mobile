import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/features/post/presentation/widgets/indicator.dart';

class PostImage extends StatefulWidget {
  const PostImage({Key? key, required this.images, this.mediaHeight}) : super(key: key);

  final List<String> images;
  final double? mediaHeight;

  @override
  _PostImageState createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: widget.mediaHeight?? 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return ImageWidget(
                borderRadius: BorderRadius.circular(10),
                canPreview: true,
                imageUrl: widget.images[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        if (widget.images.length > 1)
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Center(
              child: Indicator(
                seledtedIndex: _selectedIndex,
                items_count: widget.images.length,
              ),
            ),
          ),
      ],
    );
  }
}
