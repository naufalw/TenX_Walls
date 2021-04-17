import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final List allWallLink;
  final String categorie;
  const CategoryScreen({@required this.allWallLink, @required this.categorie});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List allWallLink = [], allHDLink = [], allThumbLink = [];
  String categorie;
  void getAllValue() {
    allWallLink = widget.allWallLink;
    categorie = widget.categorie;
    getLink(allWallLink);
    setState(() {});
  }

  void getLink(List allLink) {
    for (var i = 0; i < allWallLink.length; i++) {
      allHDLink.add(allLink[i]["url"]);
      allThumbLink.add(allLink[i]["thumb"]);
    }
  }

  @override
  void initState() {
    super.initState();
    getAllValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(categorie),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverGrid(
                delegate:
                    SliverChildBuilderDelegate((BuildContext ctx, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 3),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: allThumbLink[index],
                              fit: BoxFit.cover,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                              ),
                            )
                          ],
                        )),
                  );
                }, childCount: allThumbLink.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
                )),
          )
        ],
      ),
    );
  }
}
