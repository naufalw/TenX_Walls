import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walls_flutter/backend/database_thingy.dart';
import 'package:walls_flutter/component/category_card.dart';
import 'package:walls_flutter/screens/all_category.dart';
import 'package:walls_flutter/screens/all_papers.dart';
import 'package:walls_flutter/screens/preview_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController _carouselController = CarouselController();
  var categoryData,
      categoryLength,
      wallsData,
      kumpulanLenkThumb,
      kumpulanLenkHD,
      dataRTDB,
      categoryIndex;
  List allWallLink, allWallLinkNotShuffled;
  void getCategoryValues() async {
    FirebaseDB fbDB = FirebaseDB();
    await fbDB.getAllTheData();
    dataRTDB = fbDB.dataRTDB;
    if (dataRTDB != null) {
      await fbDB.getCategoryDB();
      await fbDB.getWallsDatabase();
    }
    allWallLinkNotShuffled = fbDB.allWallLink;
    allWallLink = fbDB.allWallLink;
    allWallLink.shuffle();
    categoryData = fbDB.categoryData;
    categoryLength = fbDB.categoryLength;
    kumpulanLenkThumb = fbDB.kumpulanLenkThumb;
    kumpulanLenkThumb.shuffle();
    categoryIndex = fbDB.wallsIndexGlobal;

    wallsData = fbDB.wallsData;
    if (categoryData != null) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getCategoryValues();
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
          body: dataRTDB == null
              ? Center(
                  child: SpinKitDoubleBounce(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
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
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Categories",
                                          style: GoogleFonts.sourceSansPro(
                                              fontSize: 27,
                                              fontWeight: FontWeight.w600)),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              backgroundColor: Theme.of(context)
                                                  .canvasColor),
                                          onPressed: () {
                                            Get.to(() => AllCategoryScreen(
                                                  categoryData: categoryData,
                                                  wallsData: wallsData,
                                                ));
                                          },
                                          child: Text(
                                            "See all categories",
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Column(
                                children: [
                                  CarouselSlider.builder(
                                      itemCount: categoryLength,
                                      itemBuilder: (BuildContext context,
                                          int itemIndex,
                                          int iDontKnowWhatsDis) {
                                        return FeaturedCategoryCard(
                                          thumbnailURL: categoryData[itemIndex]
                                              ["url"],
                                          categorie: categoryData[itemIndex]
                                              ["title"],
                                          allWallLink: wallsData[itemIndex]
                                              ["wall_link"],
                                        );
                                      },
                                      carouselController: _carouselController,
                                      options: CarouselOptions(
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.scale,
                                        viewportFraction: 1,
                                        height: 195,
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Browse",
                                            style: GoogleFonts.sourceSansPro(
                                                fontSize: 27,
                                                fontWeight: FontWeight.w600)),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .canvasColor),
                                            onPressed: () {
                                              Get.to(() => AllWallPapersScreen(
                                                    allWallLink:
                                                        allWallLinkNotShuffled,
                                                  ));
                                            },
                                            child: Text(
                                              "See all wallpapers",
                                              style: GoogleFonts.sourceSansPro(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext ctx, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 3),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: allWallLink[index]["thumb"],
                                        fit: BoxFit.cover,
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () async {
                                            String url =
                                                allWallLink[index]["url"];
                                            ProgressHUD.of(ctx).show();
                                            var file =
                                                await DefaultCacheManager()
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
                          }, childCount: 6),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.6,
                            mainAxisSpacing: 6.0,
                            crossAxisSpacing: 6.0,
                          )),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

// class CategoriesCard extends StatelessWidget {
//   const CategoriesCard({
//     Key key,
//     @required this.categoryData,
//   }) : super(key: key);

//   final Map categoryData;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//         child: Image.network(
//           categoryData["data"][itemIndex]["url"],
//         ),
//       ),
//     );
//   }
// }
