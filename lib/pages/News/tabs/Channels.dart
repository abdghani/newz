import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newz/models/sources.dart';
import 'package:newz/pages/News/bloc/channels_bloc.dart';
import 'package:newz/pages/News/component/filterChannel.dart';
import 'package:newz/pages/News/component/channelNewsList.dart';
import 'package:newz/resuable/circleTabIndicator.dart';
import 'package:newz/util/preferences.dart';
import 'package:provider/provider.dart';

class Channels extends StatefulWidget {
  @override
  _ChannelsState createState() => _ChannelsState();
}

class _ChannelsState extends State<Channels>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  late ChannelsBloc channelsBloc;
  List<Sources> activeSourceList = [];

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    var prefProvider = Provider.of<PrefProvider>(context, listen: false);
    if (prefProvider.prefs['defaultEnglish'] == true) {
      activeSourceList = sourceList
          .where((Sources element) => element.language == 'en')
          .toList();
    } else {
      activeSourceList = sourceList;
    }
    initControllers();
    fetchInitialNews();
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(kToolbarHeight,
        duration: Duration(microseconds: 300), curve: Curves.ease);
    fetchNews(activeSourceList[_tabController.index].id);
  }

  initControllers() {
    _scrollController = ScrollController();
    _tabController =
        TabController(length: activeSourceList.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
  }

  fetchInitialNews() {
    channelsBloc = BlocProvider.of<ChannelsBloc>(context);
    channelsBloc.add(GetChannelNews(activeSourceList[0].id.toString()));
  }

  // fetching news from bloc
  fetchNews(String? name) {
    channelsBloc.add(GetChannelNews(name.toString()));
  }

  WidgetChannelNameCard(Sources ch) {
    return Text(ch.name.toString());
  }

  @override
  Widget build(BuildContext context) {
    // open filter
    showFilter() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => FilterChannel()).then((value) {
        if (value != null) {
          int idx = activeSourceList
              .indexWhere((Sources element) => element.id == value);
          _tabController.animateTo(idx, duration: Duration(milliseconds: 300));
        }
      });
    }

    return SafeArea(
      child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                title: Row(
                  children: [
                    Expanded(
                      flex: 12,
                      child: TabBar(
                        onTap: (index) {
                          fetchNews(activeSourceList[index].id);
                        },
                        indicator: CircleTabIndicator(
                            color: Theme.of(context).primaryColor, radius: 0),
                        labelPadding: EdgeInsets.only(right: 10),
                        indicatorColor: Theme.of(context).backgroundColor,
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Theme.of(context).primaryColor,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12),
                        unselectedLabelStyle: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12),
                        unselectedLabelColor:
                            Theme.of(context).textTheme.subtitle2!.color,
                        tabs: List.generate(
                            activeSourceList.length,
                            (index) =>
                                WidgetChannelNameCard(activeSourceList[index])),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: showFilter,
                        child: Icon(
                          Icons.filter_alt,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                floating: true,
                pinned: true,
                toolbarHeight: 40,
                expandedHeight: 10.0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body: Container(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                  activeSourceList.length,
                  (index) =>
                      ChannelNewsList(activeSourceList[index].id.toString())),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15),
          )),
    );
  }
}
