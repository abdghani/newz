import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newz/models/news.dart';
import 'package:newz/pages/News/bloc/channels_bloc.dart';
import 'package:newz/pages/News/component/newsCard.dart';
import 'package:newz/resuable/appLoader.dart';
import 'package:newz/resuable/nodata.dart';
import 'package:newz/util/preferences.dart';
import 'package:provider/provider.dart';

class CategoryNewsList extends StatelessWidget {
  final sourceName;
  const CategoryNewsList(this.sourceName);

  @override
  Widget build(BuildContext context) {
    var prefProvider = Provider.of<PrefProvider>(context);

    Widget NewsList(state) {
      if (state.news[sourceName] == null) return AppLoader('Loading...');

      List<News> allNews = state.news[sourceName];
      List<News> filteredNews = [];
      if (prefProvider.prefs['defaultEnglish'] == true) {
        filteredNews = allNews.where((News e) => e.lang == 'en').toList();
      } else {
        filteredNews = allNews;
      }
      return filteredNews.length != 0
          ? ListView.builder(
              itemBuilder: (context, idx) =>
                  Center(child: NewsCard(filteredNews[idx])),
              itemCount: filteredNews.length,
            )
          : NoData('No News',
              'Disable `English news` in settings to view news of all languages');
    }

    Widget errorContent(state) => Container(
          child: Center(
            child: Text(state.message),
          ),
        );
    return BlocBuilder<ChannelsBloc, ChannelsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return AppLoader("Loading ...");
        } else if (state is CategoryNewsLoaded) {
          return NewsList(state);
        } else if (state is NewsError) {
          return errorContent(state);
        } else {
          return AppLoader("Loading channels news...");
        }
      },
    );
  }
}
