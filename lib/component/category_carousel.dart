import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walls_flutter/component/category_card.dart';

class CategoryCarousel extends StatelessWidget {
  const CategoryCarousel({
    Key key,
    @required this.categoryData,
    @required this.wallsData,
    @required CarouselController carouselController,
  })  : _carouselController = carouselController,
        super(key: key);

  final List categoryData;
  final List wallsData;
  final CarouselController _carouselController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
      child: Column(
        children: [
          CarouselSlider.builder(
              itemCount: categoryData.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int iDontKnowWhatsDis) {
                return AspectRatio(
                  aspectRatio: 18 / 9,
                  child: FeaturedCategoryCard(
                    thumbnailURL: categoryData[itemIndex]["url"],
                    categorie: categoryData[itemIndex]["title"],
                    allWallLink: wallsData[itemIndex]["wall_link"],
                  ),
                );
              },
              carouselController: _carouselController,
              options: CarouselOptions(
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                viewportFraction: 1,
                autoPlay: true,
                enlargeCenterPage: true,
              )),
        ],
      ),
    );
  }
}
