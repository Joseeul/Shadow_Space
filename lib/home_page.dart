import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html;
import 'package:http/http.dart' as http;
import 'package:shadow_space/helper/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<String>> fetchTrendingTopics() async {
    String url = 'https://trends24.in/indonesia/';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = html.parse(response.body);
        final trendElements =
            document.querySelectorAll('.trend-card__list li a');
        final trends = trendElements
            .map((element) => element.text.trim())
            .take(50)
            .toList();
        return trends;
      } else {
        throw Exception(
            'Failed to load trends. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching trends: $e');
      return [];
    }
  }

  late Future<List<String>> trendingTopics;

  @override
  void initState() {
    super.initState();
    trendingTopics = fetchTrendingTopics();
  }

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
            'lib/assets/Icon.png',
            width: screenWidth * 0.125,
            height: screenHeight * 0.125,
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
        body: Container(
          child: Column(
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
              FutureBuilder<List<String>>(
                future: trendingTopics,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final topics = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: topics.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 3.5),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFF353535),
                              ),
                            ),
                            color: Colors.transparent,
                            child: ListTile(
                              title: Text(
                                '${topics[index]}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            // tempat naro icon button like, comment, repost
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
