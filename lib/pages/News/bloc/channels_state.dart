part of 'channels_bloc.dart';

abstract class ChannelsState extends Equatable {
  const ChannelsState();

  @override
  List<Map<String, List<News>>> get props => [];
}

class NewsInitial extends ChannelsState {}

class NewsLoading extends ChannelsState {}

class SourceNewsLoaded extends ChannelsState {
  final Map<String, List<News>> news;

  const SourceNewsLoaded([this.news = const {}]);

  @override
  List<Map<String, List<News>>> get props => [news];
}

class RegionNewsLoaded extends ChannelsState {
  final Map<String, List<News>> news;

  const RegionNewsLoaded([this.news = const {}]);

  @override
  List<Map<String, List<News>>> get props => [news];
}

class CategoryNewsLoaded extends ChannelsState {
  final Map<String, List<News>> news;

  const CategoryNewsLoaded([this.news = const {}]);

  @override
  List<Map<String, List<News>>> get props => [news];
}

class NewsError extends ChannelsState {
  final String message;
  NewsError(this.message);
}
