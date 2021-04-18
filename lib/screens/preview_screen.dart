import 'dart:io';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:walls_flutter/component/font_size.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Preview"),
      ),
      body: Center(
        child: ExtendedImage.file(
          imgPath,
          fit: BoxFit.cover,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: (state) {
            return GestureConfig(inPageView: false, minScale: 1.0);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Information"),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "Apply"),
          BottomNavigationBarItem(
              icon: Icon(Icons.download_sharp), label: "Download"),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: "Share")
        ],
        onTap: (index) async {
          if (index == 1) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    title: Text("Select Location"),
                    children: [
                      SimpleDialogOption(
                        child: Text(
                          "Home Screen",
                          style: TextStyle(fontSize: FontSize.fontSize16),
                        ),
                        onPressed: () async {
                          await WallpaperManager.setWallpaperFromFile(
                              imgPath.path, WallpaperManager.HOME_SCREEN);
                          Get.back();
                        },
                      ),
                      SimpleDialogOption(
                        child: Text(
                          "Lock Screen",
                          style: TextStyle(fontSize: FontSize.fontSize16),
                        ),
                        onPressed: () async {
                          await WallpaperManager.setWallpaperFromFile(
                              imgPath.path, WallpaperManager.LOCK_SCREEN);
                          Get.back();
                        },
                      ),
                      SimpleDialogOption(
                        child: Text(
                          "Both",
                          style: TextStyle(fontSize: FontSize.fontSize16),
                        ),
                        onPressed: () async {
                          await WallpaperManager.setWallpaperFromFile(
                              imgPath.path, WallpaperManager.BOTH_SCREENS);
                          Get.back();
                        },
                      )
                    ],
                  );
                });
          } else if (index == 3) {
            Share.shareFiles([imgPath.path]);
          } else if (index == 2) {
            var status = await Permission.storage.status;
            if (!status.isGranted) {
              await Permission.storage.request();
            }
            Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
            String tempPath = tempDir.path;
            await imgPath.copy("$tempPath/${randomAlpha(10)}.jpg");
            Get.showSnackbar(GetBar(
              title: "Success",
              duration: Duration(seconds: 2),
              message: "Wallpaper copied to downloads folder",
            ));
          } else if (index == 0) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    title: Text("TenX-OS Wallpapers"),
                    children: [
                      SimpleDialogOption(
                        child: Text(
                          "Designed by Roger Truttmann",
                          style: TextStyle(fontSize: FontSize.fontSize16),
                        ),
                        onPressed: () async {
                          await launch("https://t.me/Roger_T");
                        },
                      ),
                      SimpleDialogOption(
                        child: Text(
                          "Lead Developer : Advaith Bath",
                          style: TextStyle(fontSize: FontSize.fontSize16),
                        ),
                        onPressed: () async {
                          await launch("https://t.me/advaithbhat");
                        },
                      ),
                      SimpleDialogOption(
                        child: Text(
                          "App Developer : Naufal Wiwit P",
                          style: TextStyle(fontSize: FontSize.fontSize16),
                        ),
                        onPressed: () async {
                          await launch("https://t.me/nauFOSS");
                        },
                      ),
                      SimpleDialogOption(
                        child: Text(
                          "TenX-OS Support Group",
                          style: TextStyle(fontSize: FontSize.fontSize16),
                        ),
                        onPressed: () async {
                          await launch("https://t.me/TenX_OS");
                        },
                      )
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}
