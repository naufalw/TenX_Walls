import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'category_screen.dart';

class AllCategoryScreen extends StatefulWidget {
  final categoryData;
  final wallsData;
  const AllCategoryScreen({this.categoryData, this.wallsData});
  @override
  _AllCategoryScreenState createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  var categoryData, wallsData;
  @override
  void initState() {
    super.initState();
    categoryData = widget.categoryData;
    wallsData = widget.wallsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              "All Categories",
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 18 / 9,
                  child: ClipRRect(
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
                            fit: BoxFit.fitWidth,
                            imageUrl: categoryData[index]["url"],
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
                                Get.to(() => CategoryScreen(
                                      allWallLink: wallsData[index]
                                          ["wall_link"],
                                      categorie: categoryData[index]["title"],
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
                  ),
                ),
              );
            }, childCount: categoryData.length),
          )
        ],
      ),
    );
  }
}
