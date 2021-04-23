import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walls_flutter/component/font_size.dart';
import 'package:walls_flutter/screens/all_papers.dart';

class BrowseRow extends StatelessWidget {
  const BrowseRow({
    Key key,
    @required this.allWallLinkNotShuffled,
  }) : super(key: key);

  final List allWallLinkNotShuffled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Browse",
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 28, fontWeight: FontWeight.w600)),
                TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Theme.of(context).canvasColor),
                    onPressed: () {
                      Get.to(() => AllWallPapersScreen(
                            allWallLink: allWallLinkNotShuffled,
                          ));
                    },
                    child: Text("See all wallpapers",
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
