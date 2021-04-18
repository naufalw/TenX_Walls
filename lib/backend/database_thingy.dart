import 'package:firebase_database/firebase_database.dart';

class FirebaseDB {
  var categoryData, categoryLength, wallsData, wallsIndexGlobal, dataRTDB;
  List allWallLink = [];
  List allWallLinkShuffled = [];
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
    print(wallsIndexGlobal);

    for (var indexglob = 0; indexglob < wallsIndexGlobal.length; indexglob++) {
      var jumlahWall = wallsData[indexglob]["wall_link"].length;
      for (var i = 0; i < jumlahWall; i++) {
        allWallLink.add(wallsData[indexglob]["wall_link"][i]);
        allWallLinkShuffled.add(wallsData[indexglob]["wall_link"][i]);
      }
    }
    allWallLinkShuffled.shuffle();
  }
}
