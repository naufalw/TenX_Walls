import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedCategoryCard extends StatelessWidget {
  final String thumbnailURL;
  final Function onTap;
  final String title;

  const FeaturedCategoryCard({
    Key key,
    @required this.thumbnailURL,
    this.onTap,
    this.title,
  })  : assert(thumbnailURL != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        ScreenUtil().setWidth(14),
      ),
      child: Container(
        width: ScreenUtil().setWidth(780),
        height: ScreenUtil().setHeight(480),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CachedNetworkImage(
              width: ScreenUtil().setWidth(985),
              height: ScreenUtil().setHeight(480),
              fit: BoxFit.cover,
              imageUrl: thumbnailURL,
            ),
            Opacity(
              opacity: 0.24,
              child: Container(
                width: ScreenUtil().setWidth(985),
                height: ScreenUtil().setHeight(480),
                color: Color(0xff4D4E51),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  print("a");
                },
                child: Container(
                  width: ScreenUtil().setWidth(985),
                  height: ScreenUtil().setHeight(480),
                  // color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
