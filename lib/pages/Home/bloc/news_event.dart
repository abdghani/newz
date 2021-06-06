part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable {
  const NewsEvent();
  @override
  List<Object> get props => [];
}

// gets a news from a source
class GetSourceNews extends NewsEvent {
  final String source;
  const GetSourceNews(this.source);
  @override
  List<Object> get props => [source];
}
