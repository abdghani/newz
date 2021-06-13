import 'package:flutter/material.dart';
import 'package:newz/models/news.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newz/util/preferences.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NewsCard extends StatelessWidget {
  final News news;
  const NewsCard(this.news, {Key? key}) : super(key: key);

  parseDate(dt) {
    return timeago.format(DateTime.parse(dt), locale: 'en_short').toString();
  }

  parseAuthor(String authName) {
    int limit = 40;
    return authName.length > limit
        ? authName.substring(0, limit) + ' ...'
        : authName;
  }

  // launch in browser
  void _launchURL(_url) async {
    await launch(_url);
  }

  String parseUrl(String url) {
    if (url.startsWith('//')) {
      return 'http:' + url;
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    Widget hasNoImageHeader = Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.73),
              ),
              child: Text(news.source!.name.toString(),
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 12, color: Colors.grey)),
            ),
          ),
        )
      ],
    );

    Widget hasImageHeader = Stack(children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          imageUrl: parseUrl(news.urlToImage.toString()),
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    value: downloadProgress.progress),
              ),
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  if (news.description != null)
                    Text(news.description.toString(),
                        // textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            color: Colors.grey[500])),
                ],
              ),
            );
          },
        ),
      ),
      Positioned(
          top: 5,
          left: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.73),
              ),
              child: Text(news.source!.name.toString(),
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 12, color: Colors.grey)),
            ),
          )),
    ]);

    Widget newsTitle = Text(news.title.toString(),
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.headline6!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 12,
            color: Colors.grey[500]));

    Widget newsFooter = Row(
      children: [
        Spacer(),
        if (news.author != null)
          Text(
            parseAuthor(news.author!).toString(),
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        SizedBox(
          width: 5,
        ),
        Icon(Icons.timer, size: 14, color: Theme.of(context).primaryColor),
        Text(
          parseDate(news.publishedAt),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );

    Widget maincard = GestureDetector(
      onTap: () => _launchURL(news.url),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Card(
          elevation: 4,
          color: Theme.of(context).backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.only(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (news.urlToImage != null) hasImageHeader,
                if (news.urlToImage == null) hasNoImageHeader,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      newsTitle,
                      newsFooter,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    return Container(child: maincard);
  }
}
