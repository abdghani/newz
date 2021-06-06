import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:newz/data/api.dart';
import 'package:newz/models/news.dart';
import 'package:newz/util/network_exceptions.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is GetSourceNews) {
      // if its initial state NewsLoaded
      // state is yielded with no value
      // News Initial State can be show
      // to show some inbitial loading page
      if (state is NewsInitial || state is NewsError) {
        yield NewsLoaded({});
      }
      try {
        // Caching the fetched news for a
        // channel in the state so that api is
        // not called every time channel changes
        Map<String, List<News>>? currentNews =
            Map.from((state as NewsLoaded).news);

        // if the news is already fetched then api
        // will not be called
        if (currentNews[event.source] == null) {
          yield NewsLoading();
          dynamic newsFetched = await getSourceNews(event.source);
          List<News> newsparsed = newsFetched['articles']
              .map<News>((_news) => News.fromJson(_news))
              .toList();
          currentNews[event.source] = newsparsed;
        }
        yield NewsLoaded(currentNews);
      } catch (err) {
        NetworkExceptions _excep = NetworkExceptions.getDioException(err);
        yield NewsError(NetworkExceptions.getErrorMessage(_excep));
      }
    }
  }
}
