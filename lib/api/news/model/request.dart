import 'package:vigilant_spork/api/news/model/sort_by.dart';

class Request {
  final String apiKey;
  final String q;
  final String? from;
  final String? to;
  final String language;
  final SortBy sortBy;
  final int pageSize;
  final int page;
  const Request({
    required this.apiKey,
    required this.q,
    this.from,
    this.language = 'en',
    this.page = 1,
    this.pageSize = 100,
    this.sortBy = SortBy.publishedAt,
    this.to,
  });
}
