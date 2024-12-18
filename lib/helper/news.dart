// import 'dart:convert';

// import 'package:shadow_space/helper/news_article.dart';
// import 'package:http/http.dart' as http;

// class News {
//   List<NewsArticle> news_article = [];
//   Future<void> getNews() async {
//     String url =
//         'https://newsapi.org/v2/top-headlines?country=us&apiKey=6649db36b05042b386247dfe6ee66ceb';
//     var response = await http.get(Uri.parse(url));
//     var jsonData = jsonDecode(response.body);

//     if (jsonData['status'] == 'ok') {
//       jsonData['articles'].forEach(
//         (element) {
//           if (element['urlToImage'] != null && element['description'] != null) {
//             NewsArticle newsArticle = NewsArticle(
//               element['author'],
//               element['title'],
//               element['description'],
//               element['url'],
//               element['urlToImage'],
//               element['content'],
//             );
//             news_article.add(newsArticle);
//           }
//         },
//       );
//     }
//   }
// }
