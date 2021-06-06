part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Map<String, List<News>>> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final Map<String, List<News>> news;

  const NewsLoaded([this.news = const {}]);

  @override
  List<Map<String, List<News>>> get props => [news];
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}
