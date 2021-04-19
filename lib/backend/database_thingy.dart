import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:path_provider/path_provider.dart';

class JsonDB {
  Map dataJson;
  List allWallLink = [],
      allWallLinkShuffled = [],
      categoryData = [],
      wallsData = [];
  Dio dio = Dio();
  var docDir, options;
  String requestURL =
      "https://raw.githubusercontent.com/TenX-OS/TenX_Wallpapers/master/tenx-papersdb.json";
  Future<void> configureDio() async {
    docDir = await getApplicationDocumentsDirectory();
    options = CacheOptions(
      store: HiveCacheStore(docDir.path),
      policy: CachePolicy.request,
      priority: CachePriority.normal,
    );
    dio.interceptors.add(DioCacheInterceptor(options: options));
  }

  Future<void> getJson() async {
    await configureDio();
    var request = await dio.get(requestURL, options: options.toOptions());
    dataJson = jsonDecode(request.data);
  }

  Future<void> refreshJson() async {
    var request = await dio.get(requestURL, options: options.toOptions());
    dataJson = jsonDecode(request.data);
  }

  Future<void> getAllData() async {
    wallsData = dataJson["database"];
    List wallsIndexGlobal = dataJson["index"];
    allWallLink.clear();
    allWallLinkShuffled.clear();
    for (var indexglob = 0; indexglob < wallsIndexGlobal.length; indexglob++) {
      var jumlahWall = wallsData[indexglob]["wall_link"].length;
      for (var i = 0; i < jumlahWall; i++) {
        allWallLink.add(wallsData[indexglob]["wall_link"][i]);
        allWallLinkShuffled.add(wallsData[indexglob]["wall_link"][i]);
      }
    }
    allWallLinkShuffled.shuffle();
    categoryData = dataJson["banners"];
  }
}
