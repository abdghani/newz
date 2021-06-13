import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:newz/data/api.dart';
import 'package:newz/models/news.dart';
import 'package:newz/services/nlp.dart';
import 'package:newz/util/network_exceptions.dart';
import 'package:newz/util/preferences.dart';

part 'channels_event.dart';
part 'channels_state.dart';

class ChannelsBloc extends Bloc<ChannelsEvent, ChannelsState> {
  ChannelsBloc() : super(NewsInitial());

  @override
  Stream<ChannelsState> mapEventToState(ChannelsEvent event) async* {
    if (event is SetInitialNews) {
      yield NewsInitial();
    }
    if (event is GetChannelNews) {
      // if its initial state SourceNewsLoaded
      // state is yielded with no value
      // News Initial State can be show
      // to show some inbitial loading page
      if (state is! SourceNewsLoaded) {
        yield SourceNewsLoaded({});
      }
      try {
        // Caching the fetched news for a
        // channel in the state so that api is
        // not called every time channel changes
        Map<String, List<News>>? currentNews =
            Map.from((state as SourceNewsLoaded).news);

        // if the news is already fetched then api
        // will not be called
        if (currentNews[event.source] == null) {
          yield NewsLoading();
          dynamic newsFetched = await getSourceNews(event.source);
          dynamic articles = await parselanguage(newsFetched['articles']);
          List<News> newsparsed =
              articles.map<News>((_news) => News.fromJson(_news)).toList();
          currentNews[event.source] = newsparsed;
        }
        yield SourceNewsLoaded(currentNews);
      } catch (err) {
        NetworkExceptions _excep = NetworkExceptions.getDioException(err);
        yield NewsError(NetworkExceptions.getErrorMessage(_excep));
      }
    } else if (event is GetRegionNews) {
      if (state is! RegionNewsLoaded) {
        yield RegionNewsLoaded({});
      }
      try {
        Map<String, List<News>>? currentNews =
            Map.from((state as RegionNewsLoaded).news);
        yield NewsLoading();
        dynamic newsFetched = await getRegionNews(event.code, event.category);
        dynamic articles = await parselanguage(newsFetched['articles']);
        List<News> newsparsed =
            articles.map<News>((_news) => News.fromJson(_news)).toList();
        currentNews[event.code] = newsparsed;
        yield RegionNewsLoaded(currentNews);
      } catch (err) {
        NetworkExceptions _excep = NetworkExceptions.getDioException(err);
        yield NewsError(NetworkExceptions.getErrorMessage(_excep));
      }
    } else if (event is GetCategoryNews) {
      if (state is! CategoryNewsLoaded) {
        yield CategoryNewsLoaded({});
      }
      try {
        Map<String, List<News>>? currentNews =
            Map.from((state as CategoryNewsLoaded).news);

        if (currentNews[event.name] == null) {
          yield NewsLoading();
          dynamic newsFetched = await getCategoryNews(event.name,
              defaultEnglish: event.defaultEnglish);
          dynamic articles = await parselanguage(newsFetched['articles']);
          List<News> newsparsed =
              articles.map<News>((_news) => News.fromJson(_news)).toList();
          currentNews[event.name] = newsparsed;
        }
        yield CategoryNewsLoaded(currentNews);
      } catch (err) {
        print(err);
        NetworkExceptions _excep = NetworkExceptions.getDioException(err);
        yield NewsError(NetworkExceptions.getErrorMessage(_excep));
      }
    }
  }
}

parselanguage(List<dynamic> articles) async {
  for (var i = 0; i < articles.length; i++) {
    articles[i]['lang'] = await getLanguage(articles[i]['title']);
  }
  return articles;
}
