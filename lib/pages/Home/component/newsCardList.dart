import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newz/pages/Home/bloc/news_bloc.dart';
import 'package:newz/pages/Home/component/newsCard.dart';
import 'package:newz/resuable/appLoader.dart';

class NewsCardList extends StatelessWidget {
  final sourceName;

  const NewsCardList(this.sourceName);

  @override
  Widget build(BuildContext context) {
    // list of news
    Widget NewsList(state) {
      return ListView.builder(
        itemBuilder: (context, idx) => NewsCard(state.news[sourceName][idx]),
        itemCount:
            state.news[sourceName] != null ? state.news[sourceName].length : 0,
      );
    }

    Widget errorContent(state) => Container(
          child: Center(
            child: Text(state.message),
          ),
        );
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return AppLoader("Loading ...");
        } else if (state is NewsLoaded) {
          return NewsList(state);
        } else if (state is NewsError) {
          return errorContent(state);
        } else {
          return Text("Default state");
        }
      },
    );
  }
}
