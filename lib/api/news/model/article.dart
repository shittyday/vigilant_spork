import 'package:vigilant_spork/api/news/model/source.dart';

class Article {
  final Source source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String content;

  const Article._({
    required this.source,
    required this.author,
    required this.content,
    required this.description,
    required this.publishedAt,
    required this.title,
    required this.url,
    required this.urlToImage,
  });
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article._(
        source: Source.fromJson(json['source']),
        author: json['author'],
        content: json['content'],
        description: json['description'],
        publishedAt: json['publishedAt'],
        title: json['title'],
        url: json['url'],
        urlToImage: json['urlToImage']);
  }
}
