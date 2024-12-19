import 'package:flutter/material.dart';
import 'package:shadow_space/helper/news_service.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({super.key});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'News Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (NewsService.selectedNews!.urlToImage != 'null' &&
                NewsService.selectedNews!.urlToImage.isNotEmpty)
              Image.network(
                NewsService.selectedNews!.urlToImage,
                fit: BoxFit.cover,
              ),
            SizedBox(
              height: 5,
            ),
            Text(
              NewsService.selectedNews!.author,
              style: TextStyle(
                color: Color(0xFFcccccc),
                fontFamily: 'j-reg',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              NewsService.selectedNews!.title,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'j-bold',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              NewsService.selectedNews!.description,
              style: TextStyle(
                color: Color(0xFFcccccc),
                fontFamily: 'j-medium',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              NewsService.selectedNews!.content,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'j-reg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
