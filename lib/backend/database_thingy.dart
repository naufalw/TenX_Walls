import 'package:firebase_database/firebase_database.dart';

class FirebaseDB {
  var categoryData, categoryLength, wallsData, wallsIndexGlobal, dataRTDB;
  List kumpulanLenkThumb = [];
  List kumpulanLenkHD = [];
  Future<void> getAllTheData() async {
    final fbInstance = FirebaseDatabase.instance;
    await fbInstance.setPersistenceEnabled(true);
    await fbInstance.setPersistenceCacheSizeBytes(10000);
    final databaseReference = fbInstance.reference();
    await databaseReference.once().then((DataSnapshot snapshot) {
      dataRTDB = snapshot.value;
    });
  }

  Future<void> getCategoryDB() async {
    categoryData = dataRTDB["banners"];
    categoryLength = dataRTDB["banners"].length;
  }

  Future<void> getWallsDatabase() async {
    wallsData = dataRTDB["database"];
    final fbInstance = FirebaseDatabase.instance;
    final databaseReference = fbInstance.reference().child("index");
    await databaseReference.once().then((DataSnapshot snapshot) {
      wallsIndexGlobal = snapshot.value;
    });

    for (var indexglob = 0; indexglob < wallsIndexGlobal.length; indexglob++) {
      var jumlahWall = wallsData[indexglob]["wall_link"].length;
      for (var i = 0; i < jumlahWall; i++) {
        var linkThumb = wallsData[indexglob]["wall_link"][i]["thumb"];
        var linkHD = wallsData[indexglob]["wall_link"][i]["url"];
        kumpulanLenkThumb.add(linkThumb);
        kumpulanLenkHD.add(linkHD);
      }
    }
  }
}
