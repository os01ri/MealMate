import 'package:flutter/material.dart';
import 'package:mealmate/core/ui/theme/colors.dart';

class TransitionAppBar extends StatelessWidget {
  final Widget avatar;
  final Widget title;
  final double extent;

  const TransitionAppBar(
      {required this.avatar, required this.title, this.extent = 250, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
          avatar: avatar, title: title, extent: extent > 200 ? extent : 200),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarMarginTween = EdgeInsetsTween(
    end: EdgeInsets.only(left: 50, top: 36.0),
  );

  final _titleMarginTween = EdgeInsetsTween(
    begin: EdgeInsets.only(bottom: 20),
    end: EdgeInsets.only(left: 104, top: 36),
  );

  final _avatarAlignTween =
      AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.topLeft);

  final Widget avatar;
  final Widget title;
  final double extent;

  _TransitionAppBarDelegate(
      {required this.avatar, required this.title, this.extent = 250})
      : assert(avatar != null),
        assert(extent == null || extent >= 200),
        assert(title != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 72 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final titleMargin = _titleMarginTween.lerp(progress);

    final avatarAlign = _avatarAlignTween.lerp(progress);

    final avatarSize = (1 - progress) * 200 + 32;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: 80,
          constraints: BoxConstraints(maxHeight: minExtent),
          color: Colors.white,
          child: Padding(
            padding: titleMargin,
            child: Align(alignment: avatarAlign, child: title),
          ),
        ),
        Positioned(
            top: 20,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ))),
        Padding(
          padding: avatarMargin,
          child: Align(
            alignment: avatarAlign,
            child: SizedBox(
              height: avatarSize,
              width: avatarSize,
              child: avatar,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }
}
