import 'package:flutter/material.dart';
import 'package:shadow_space/tab_news.dart';
import 'package:shadow_space/tab_trending.dart';
// import 'package:shadow_space/helper/topic_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Image.asset(
            'lib/assets/ui_icon/Icon.png',
            width: screenWidth * 0.125,
            height: screenHeight * 0.125,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile_page');
            },
            icon: Image.asset(
              'lib/assets/ui_icon/account.png',
              width: screenWidth * 0.1,
              height: screenHeight * 0.1,
            ),
          ),
          toolbarHeight: screenHeight * 0.1,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.001),
            child: Container(
              color: Colors.white,
              height: screenHeight * 0.001,
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Trending Topics',
                ),
                Tab(
                  text: 'Top News',
                )
              ],
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              dividerColor: Colors.transparent,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TabTrending(),
                  TabNews(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
