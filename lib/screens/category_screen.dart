import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:walls_flutter/screens/preview_screen.dart';

class CategoryScreen extends StatefulWidget {
  final List allWallLink;
  final String categorie;
  const CategoryScreen({@required this.allWallLink, @required this.categorie});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List allWallLink = [], allHDLink = [], allThumbLink = [];
  String categorie;
  void getAllValue() {
    allWallLink = widget.allWallLink;
    categorie = widget.categorie;
    getLink(allWallLink);
  }

  void getLink(List allLink) {
    for (var i = 0; i < allWallLink.length; i++) {
      allHDLink.add(allLink[i]["url"]);
      allThumbLink.add(allLink[i]["thumb"]);
    }
  }

  @override
  void initState() {
    super.initState();
    getAllValue();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      indicatorColor: Colors.black45,
      borderColor: Colors.black87,
      backgroundColor: Colors.black87,
      borderWidth: 0.0,
      barrierColor: Colors.black45,
      indicatorWidget: Center(
        child: SpinKitDoubleBounce(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(categorie),
              floating: true,
              snap: true,
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0.0,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(8),
                  vertical: ScreenUtil().setHeight(10)),
              sliver: SliverGrid(
                  delegate:
                      SliverChildBuilderDelegate((BuildContext ctx, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(3.0),
                          horizontal: ScreenUtil().setWidth(14.0)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: allThumbLink[index],
                                fit: BoxFit.cover,
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    String url = allHDLink[index];
                                    ProgressHUD.of(ctx).show();
                                    var file = await DefaultCacheManager()
                                        .getSingleFile(url);
                                    if (file != null) {
                                      ProgressHUD.of(ctx).dismiss();
                                      Get.to(() => PreviewScreen(
                                            url: url,
                                            imgPath: file,
                                          ));
                                    }
                                  },
                                ),
                              )
                            ],
                          )),
                    );
                  }, childCount: allThumbLink.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: ScreenUtil().setHeight(6.0),
                    crossAxisSpacing: ScreenUtil().setWidth(6.0),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
