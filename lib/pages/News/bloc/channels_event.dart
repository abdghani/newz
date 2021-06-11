part of 'channels_bloc.dart';

@immutable
abstract class ChannelsEvent extends Equatable {
  const ChannelsEvent();
  @override
  List<Object> get props => [];
}

// gets a news from a source
class GetChannelNews extends ChannelsEvent {
  final String source;
  const GetChannelNews(this.source);
  @override
  List<Object> get props => [source];
}

class GetRegionNews extends ChannelsEvent {
  final String code;
  final String category;
  const GetRegionNews(this.code, this.category);
  @override
  List<Object> get props => [code, category];
}

class GetCategoryNews extends ChannelsEvent {
  final String name;
  const GetCategoryNews(this.name);
  @override
  List<Object> get props => [name];
}
