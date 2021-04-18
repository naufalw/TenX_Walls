import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:walls_flutter/screens/preview_screen.dart';

class RandomWallsGrid extends StatelessWidget {
  const RandomWallsGrid({
    Key key,
    @required this.allWallLinkShuffled,
    @required this.nHomeWalls,
  }) : super(key: key);

  final List allWallLinkShuffled;
  final int nHomeWalls;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 3),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: allWallLinkShuffled[index]["thumb"],
                      fit: BoxFit.cover,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          String url = allWallLinkShuffled[index]["url"];
                          ProgressHUD.of(ctx).show();
                          var file =
                              await DefaultCacheManager().getSingleFile(url);
                          if (file != null) {
                            ProgressHUD.of(ctx).dismiss();
                            Get.to(() => PreviewScreen(
                                  url: url,
                                  imgPath: file,
                                ));
                          }
                        },
                      ),
                    )
                  ],
                )),
          );
        }, childCount: nHomeWalls),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
        ));
  }
}
