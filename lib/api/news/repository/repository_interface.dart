import 'package:vigilant_spork/api/news/model/request.dart';
import 'package:vigilant_spork/api/news/model/response.dart';

abstract class IRepository {
  Future<Response> fetchEverything({
    required Request request,
  }) =>
      throw UnimplementedError('fetchEverything not implemented');
}
