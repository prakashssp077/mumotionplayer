import 'package:flutter/material.dart';
import 'package:mumotionplayer/models/horizontalViewData.dart';
import 'package:mumotionplayer/widgets/GridView.dart';
import 'package:mumotionplayer/widgets/horizontalListView.dart';
class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff4f4f4f),
                Color(0xff121212),
              ],
              begin: Alignment.topLeft,
              end: FractionalOffset(0.1, 0.3),
            )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/myProfile");
                      },
                    ),
                  ),
                  GridViewList(),
                  HorizontalListView(
                    aboveText: "Recently Played",
                    dynamicData: horizontalData,
                  ),
                  HorizontalListView(
                    aboveText: "Music Festival",
                    dynamicData: horizontalData01,
                  ),
                  HorizontalListView(
                    aboveText: "Top 10 Podcast",
                    dynamicData: horizontalData02,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
