import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vigilant_spork/api/news/model/article.dart';

class News extends StatelessWidget {
  final CachedNetworkImage image;
  final Article article;
  const News({
    super.key,
    required this.image,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(.5),
        elevation: 0,
        title: Text(article.title),
        titleSpacing: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (article.author != null)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  article.author!,
                  textAlign: TextAlign.left,
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                article.title,
                style: DefaultTextStyle.of(context).style.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
              )),
          image,
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              article.description,
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              article.content,
            ),
          ),
          RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                  text: 'Source',
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchUrl(Uri.parse(article.url));
                    })),
          Text(
            article.publishedAt,
            textAlign: TextAlign.right,
          ),
        ],
      )),
    );
  }
}
