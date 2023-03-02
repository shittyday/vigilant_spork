import 'package:vigilant_spork/api/news/model/status.dart';

import 'article.dart';

class Response {
  final Status status;
  final int totalResults;
  final String? code;
  final String? message;
  final List<Article> articles;

  const Response._({
    this.code,
    this.message,
    required this.articles,
    required this.status,
    required this.totalResults,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response._(
      articles: _mapListToArticleList(json['articles']),
      status: Status.parseToEnum(json['status']),
      totalResults: json['totalResults'],
      code: json['code'],
      message: json['message'],
    );
  }

  static List<Article> _mapListToArticleList(List list) {
    List<Article> articles = [];
    for (final json in list) {
      articles.add(Article.fromJson(json));
    }
    return articles;
  }
}
