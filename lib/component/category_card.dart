import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walls_flutter/screens/category_screen.dart';

class FeaturedCategoryCard extends StatelessWidget {
  final String thumbnailURL;
  final List allWallLink;
  final String categorie;

  const FeaturedCategoryCard({
    @required this.thumbnailURL,
    @required this.allWallLink,
    @required this.categorie,
  });

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
                  print(categorie);
                  Get.to(() => CategoryScreen(
                        allWallLink: allWallLink,
                        categorie: categorie,
                      ));
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
