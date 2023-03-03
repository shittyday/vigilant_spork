import 'package:flutter/material.dart';
import 'package:vigilant_spork/api/news/model/request.dart';
import 'package:vigilant_spork/api/news/model/response.dart';
import 'package:vigilant_spork/api/news/model/status.dart';
import 'package:vigilant_spork/api/news/repository/repository_interface.dart';
import 'package:vigilant_spork/widgets/article_element.dart';

const _apiKey = String.fromEnvironment(
  'apiKey',
);

class ServiceNewsPage extends StatelessWidget {
  const ServiceNewsPage({
    super.key,
    required this.repository,
  });
  final IRepository repository;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
        future: repository.fetchEverything(
          request: const Request(apiKey: _apiKey, q: 'sport'),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return ErrorWidget(Exception(snapshot.error));
            }
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.ok:
                  return SafeArea(
                      child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Sport News',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                            ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Expanded(
                          child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: snapshot.data?.articles.length,
                        itemBuilder: (context, index) {
                          return ArticleElement(
                            article: snapshot.data!.articles[index],
                          );
                        },
                      ))
                    ],
                  ));
                case Status.error:
                  return ErrorWidget(Exception(snapshot.data!.message));
              }
            } else {
              return const Center(
                child: Text('Empty news'),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
