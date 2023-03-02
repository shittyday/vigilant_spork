import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';

import 'package:http/http.dart';
import 'package:vigilant_spork/api/news/api.dart';
import 'package:vigilant_spork/api/news/model/request.dart' as app_req;
import 'package:vigilant_spork/api/news/model/response.dart' as app_resp;
import 'package:vigilant_spork/api/news/repository/repository_interface.dart';

class Repository implements IRepository {
  const Repository();

  @override
  Future<app_resp.Response> fetchEverything(
      {required app_req.Request request}) async {
    try {
      final queryParam = <String, dynamic>{
        'q': request.q,
        if (request.from != null) 'from': request.from,
        if (request.to != null) 'to': request.to,
        'language': request.language,
        'sortBy': request.sortBy.name,
        'pageSize': request.pageSize.toString(),
        'page': request.page.toString(),
        'apiKey': request.apiKey,
      };
      final uri = Uri.https(apiUrl, '$v2$everythingPath', queryParam);
      final response = await get(
        uri,
      );
      if (response.statusCode != 200) throw Exception('${response.statusCode}');
      final json = await Isolate.run(
          () => jsonDecode(response.body) as Map<String, dynamic>);
      return await Isolate.run(() => app_resp.Response.fromJson(json));
    } catch (e, stackTrace) {
      log('$e $stackTrace');
      rethrow;
    }
  }
}
