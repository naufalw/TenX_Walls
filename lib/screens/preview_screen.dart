import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class PreviewScreen extends StatefulWidget {
  final File imgPath;
  final String url;
  const PreviewScreen({this.imgPath, this.url});
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  String url;
  File imgPath;
  void getAllValue() {
    imgPath = widget.imgPath;
    url = widget.url;
  }

  @override
  void initState() {
    super.initState();
    getAllValue();
  }

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: ThemeData.dark().copyWith(
        dialogTheme:
            DialogTheme(contentTextStyle: TextStyle(color: Colors.red)),
        dialogBackgroundColor: Color(0xFF1B1717),
        backgroundColor: Color(0xFF1B1717),
        primaryColor: Color(0xFF1B1717),
        canvasColor: Color(0xFF1B1717),
        scaffoldBackgroundColor: Color(0xFF1B1717),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Preview"),
        ),
        body: PinchZoom(image: Image.file(imgPath)),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          currentIndex: 1,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.info), label: "Information"),
            BottomNavigationBarItem(icon: Icon(Icons.check), label: "Apply"),
            BottomNavigationBarItem(
                icon: Icon(Icons.download_sharp), label: "Download")
          ],
          onTap: (index) {
            if (index == 1) {
              // Get.defaultDialog(
              //     backgroundColor: Theme.of(context).canvasColor,
              //     content: Container(
              //         color: Theme.of(context).canvasColor,
              //         child: SimpleDialog(
              //           backgroundColor: Theme.of(context).canvasColor,
              //           children: [
              //             SimpleDialogOption(
              //               child: Text("Hennn"),
              //             ),
              //             SimpleDialogOption(
              //               child: Text("Hennn"),
              //             ),
              //             SimpleDialogOption(
              //               child: Text("Hennn"),
              //             )
              //           ],
              //         )));
              showConfirmationDialog(
                  context: context,
                  title: "Select Location",
                  actions: [
                    AlertDialogAction(label: "Home Screen", key: "home"),
                    AlertDialogAction(label: "Lock Screen", key: "lock"),
                    AlertDialogAction(label: "Both", key: "both"),
                  ]).then((value) async {
                if (value == "home") {
                  await WallpaperManager.setWallpaperFromFile(
                      imgPath.path, WallpaperManager.HOME_SCREEN);
                } else if (value == "lock") {
                  await WallpaperManager.setWallpaperFromFile(
                      imgPath.path, WallpaperManager.LOCK_SCREEN);
                }
                if (value == "both") {
                  await WallpaperManager.setWallpaperFromFile(
                      imgPath.path, WallpaperManager.BOTH_SCREENS);
                }
              });
            }
          },
        ),
      ),
    );
  }
}
