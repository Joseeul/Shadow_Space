import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html;
import 'package:http/http.dart' as http;
import 'package:shadow_space/helper/topic.dart';
import 'package:shadow_space/helper/topic_service.dart';

class TabTrending extends StatefulWidget {
  const TabTrending({super.key});

  @override
  State<TabTrending> createState() => _TabTrendingState();
}

class _TabTrendingState extends State<TabTrending> {
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<String>>(
        future: trendingTopics,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasData) {
            final topics = snapshot.data!;
            return Expanded(
              child: ListView.builder(
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // TopicService.selectedTopic?.index = index;
                      // TopicService.selectedTopic?.title = topics[index];
                      TopicService.selectedTopic =
                          Topic(index: index, title: topics[index]);
                      Navigator.pushNamed(context, '/insert_page');
                    },
                    child: Card(
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
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
