import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';
import 'package:share/share.dart';
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
        body: Center(
          child: ExtendedImage.file(
            imgPath,
            fit: BoxFit.cover,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (state) {
              return GestureConfig(inPageView: false);
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          currentIndex: 1,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.info), label: "Information"),
            BottomNavigationBarItem(icon: Icon(Icons.check), label: "Apply"),
            BottomNavigationBarItem(
                icon: Icon(Icons.download_sharp), label: "Download"),
            BottomNavigationBarItem(icon: Icon(Icons.share), label: "Share")
          ],
          onTap: (index) async {
            if (index == 1) {
              showConfirmationDialog(
                  context: context,
                  title: "Select Location",
                  actions: [
                    AlertDialogAction(label: "Home Screen", key: "home"),
                    AlertDialogAction(label: "Lock Screen", key: "lock"),
                    AlertDialogAction(label: "Both", key: "both"),
                  ]).then((value) async {
                try {
                  if (value == "home") {
                    await WallpaperManager.setWallpaperFromFile(
                        imgPath.path, WallpaperManager.HOME_SCREEN);
                  } else if (value == "lock") {
                    await WallpaperManager.setWallpaperFromFile(
                        imgPath.path, WallpaperManager.LOCK_SCREEN);
                  } else if (value == "both") {
                    await WallpaperManager.setWallpaperFromFile(
                        imgPath.path, WallpaperManager.BOTH_SCREENS);
                  }
                  Get.showSnackbar(GetBar(
                    title: "Success",
                    message: "Wallpaper has been set",
                    duration: Duration(seconds: 2),
                  ));
                } catch (e) {
                  Get.showSnackbar(GetBar(
                    title: "Error",
                    message: e.toString(),
                    duration: Duration(seconds: 2),
                  ));
                }
              });
            } else if (index == 3) {
              Share.shareFiles([imgPath.path]);
            } else if (index == 2) {
              var status = await Permission.storage.status;
              if (!status.isGranted) {
                await Permission.storage.request();
              }
              Directory tempDir =
                  await DownloadsPathProvider.downloadsDirectory;
              String tempPath = tempDir.path;
              await imgPath.copy("$tempPath/${randomAlpha(10)}.jpg");
              Get.showSnackbar(GetBar(
                title: "Success",
                duration: Duration(seconds: 2),
                message: "Wallpaper copied to downloads folder",
              ));
            } else if (index == 0) {
              showOkAlertDialog(
                  context: context,
                  title: "Information",
                  message:
                      "TenX OS Wallpaper\nDesigned by Roger Truttmann\nLead Developer : Advaith Bath\nApp Developer : Naufal Wiwit P");
            }
          },
        ),
      ),
    );
  }
}
