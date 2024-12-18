import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shadow_space/helper/news_article.dart';
import 'package:http/http.dart' as http;

class TabNews extends StatefulWidget {
  const TabNews({super.key});

  @override
  State<TabNews> createState() => _TabNewsState();
}

class _TabNewsState extends State<TabNews> {
  Future<List<NewsArticle>> fetchNews() async {
    var url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=6649db36b05042b386247dfe6ee66ceb';
    try {
      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        final List<dynamic> articles =
            jsonData['articles']; // Perbaikan di sini
        return articles
            .map((jsonResponse) => NewsArticle.fromJson(jsonResponse))
            .toList(); // Ubah Iterable menjadi List
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Berita Terkini'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada berita tersedia',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  color: Colors.grey[900],
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: article.urlToImage != 'null'
                        ? Image.network(
                            article.urlToImage!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.article, color: Colors.white),
                    title: Text(
                      article.title ?? 'Judul tidak tersedia',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      article.description ?? 'Deskripsi tidak tersedia',
                      style: TextStyle(color: Colors.white70),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      // Tambahkan aksi jika ingin membuka detail artikel
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
