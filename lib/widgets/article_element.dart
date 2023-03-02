import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vigilant_spork/api/news/model/article.dart';
import 'package:vigilant_spork/page/service_pages/news/news.dart';

class ArticleElement extends StatefulWidget {
  final Article article;
  const ArticleElement({
    super.key,
    required this.article,
  });

  @override
  State<ArticleElement> createState() => _ArticleElementState();
}

class _ArticleElementState extends State<ArticleElement> {
  late final cachedNetwok = CachedNetworkImage(
    imageUrl: widget.article.urlToImage ?? '',
    progressIndicatorBuilder: (context, url, downloadProgress) => Center(
      child: CircularProgressIndicator(value: downloadProgress.progress),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => News(image: cachedNetwok,
              article: widget.article,
              ),
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          cachedNetwok,
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.article.title,
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.article.description,
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.article.publishedAt,
            textAlign: TextAlign.right,
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
