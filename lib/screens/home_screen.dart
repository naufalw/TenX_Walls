import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walls_flutter/backend/database_thingy.dart';
import 'package:walls_flutter/component/category_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var categoryData, categoryLength, wallsData;
  void getCategoryValues() async {
    FirebaseDB fbDB = FirebaseDB();
    await fbDB.getAllTheData();
    await fbDB.getCategoryDB();
    await fbDB.getWallsDatabase();
    categoryData = fbDB.categoryData;
    categoryLength = fbDB.categoryLength;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: categoryData == null
          ? Center(
              child: SpinKitDoubleBounce(
                color: Theme.of(context).primaryColor,
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0.0,
                    centerTitle: true,
                    title: Text("Ten-X Wallpapers",
                        style: GoogleFonts.mukta(
                            fontSize: 39, fontWeight: FontWeight.w800))),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 25),
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
                                                  BorderRadius.circular(15)),
                                          backgroundColor:
                                              Theme.of(context).canvasColor),
                                      onPressed: () {},
                                      child: Text(
                                        "See all",
                                        style: GoogleFonts.sourceSansPro(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: CarouselSlider.builder(
                              itemCount: categoryLength,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int iDontKnowWhatsDis) {
                                return FeaturedCategoryCard(
                                    thumbnailURL: categoryData[itemIndex]
                                        ["url"]);
                              },
                              options: CarouselOptions(
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.scale,
                                viewportFraction: 1,
                                height: 195,
                                autoPlay: true,
                                enlargeCenterPage: true,
                              )),
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
                                                    BorderRadius.circular(15)),
                                            backgroundColor:
                                                Theme.of(context).canvasColor),
                                        onPressed: () {},
                                        child: Text(
                                          "See all",
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
              ],
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
