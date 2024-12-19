class NewsArticle {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;

  NewsArticle(
      {required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.content});
  factory NewsArticle.fromJson(Map<String, dynamic> json) => NewsArticle(
        author: json['author'].toString(),
        title: json['title'].toString(),
        description: json['description'].toString(),
        url: json['url'].toString(),
        urlToImage: json['urlToImage'].toString(),
        content: json['content'].toString(),
      );
}
