import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walls_flutter/backend/database_thingy.dart';
import 'package:walls_flutter/component/browse_row.dart';
import 'package:walls_flutter/component/categories_row.dart';
import 'package:walls_flutter/component/category_carousel.dart';
import 'package:walls_flutter/component/random_walls_grid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController _carouselController = CarouselController();
  List allWallLinkShuffled, allWallLinkNotShuffled, categoryData, wallsData;
  Map dataJson;
  JsonDB jsonDB = JsonDB();
  int nHomeWalls = 6;

  void getAllData() async {
    await jsonDB.getJson();
    dataJson = jsonDB.dataJson;
    if (dataJson != null) {
      await jsonDB.getAllData();
    }
    allWallLinkNotShuffled = jsonDB.allWallLink;
    allWallLinkShuffled = jsonDB.allWallLinkShuffled;
    categoryData = jsonDB.categoryData;
    wallsData = jsonDB.wallsData;
    if (wallsData != null) {
      setState(() {});
    }
  }

  Future<void> refreshData() async {
    await jsonDB.refreshJson();
    await jsonDB.getAllData();
    dataJson = jsonDB.dataJson;
    allWallLinkNotShuffled = jsonDB.allWallLink;
    allWallLinkShuffled = jsonDB.allWallLinkShuffled;
    categoryData = jsonDB.categoryData;
    wallsData = jsonDB.wallsData;
    setState(() {});
  }

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  @override
  void dispose() {
    _carouselController.stopAutoPlay();
    super.dispose();
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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor:
                Theme.of(context).scaffoldBackgroundColor),
        child: Scaffold(
          body: dataJson == null
              ? Center(
                  child: SpinKitDoubleBounce(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : EasyRefresh.custom(
                  header: BezierCircleHeader(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onRefresh: () async {
                    refreshData();
                  },
                  slivers: [
                    SliverAppBar(
                        snap: true,
                        floating: true,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        elevation: 0.0,
                        centerTitle: true,
                        title: Text("Ten-X Wallpapers",
                            style: GoogleFonts.mukta(
                                fontSize: 39, fontWeight: FontWeight.w800))),
                    SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 25),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            CategoriesRow(
                                categoryData: categoryData,
                                wallsData: wallsData),
                            CategoryCarousel(
                                categoryData: categoryData,
                                wallsData: wallsData,
                                carouselController: _carouselController),
                            BrowseRow(
                                allWallLinkNotShuffled: allWallLinkNotShuffled),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      sliver: RandomWallsGrid(
                          allWallLinkShuffled: allWallLinkShuffled,
                          nHomeWalls: nHomeWalls),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
