import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walls_flutter/screens/all_category.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({
    Key key,
    @required this.categoryData,
    @required this.wallsData,
  }) : super(key: key);

  final List categoryData;
  final List wallsData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Categories",
            style: GoogleFonts.sourceSansPro(
                fontSize: 27, fontWeight: FontWeight.w600)),
        TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Theme.of(context).canvasColor),
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
                  color: Theme.of(context).primaryColor),
            ))
      ],
    );
  }
}
