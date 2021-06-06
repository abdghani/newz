import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newz/models/sources.dart';
import 'package:newz/pages/Home/bloc/news_bloc.dart';
import 'package:newz/pages/Home/component/filterChannel.dart';
import 'package:newz/pages/Home/component/newsCardList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  late NewsBloc newsBloc;

  _smoothScrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(microseconds: 300), curve: Curves.ease);
    fetchNews(sourceList[_tabController.index].id);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: sourceList.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
    newsBloc = BlocProvider.of<NewsBloc>(context);
    newsBloc.add(GetSourceNews(sourceList[0].id.toString()));
  }

  // fetching news from bloc
  fetchNews(String? name) {
    newsBloc.add(GetSourceNews(name.toString()));
  }

  @override
  Widget build(BuildContext context) {
    // open filter
    showFilter() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => FilterState()).then((value) {
        if (value != null) {
          int idx =
              sourceList.indexWhere((Sources element) => element.id == value);
          _tabController.animateTo(idx, duration: Duration(milliseconds: 300));
        }
      });
    }

    return NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Newz",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      tooltip: 'Filter Channels',
                      onPressed: showFilter,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 25),
              child: TabBar(
                onTap: (index) {
                  fetchNews(sourceList[index].id);
                },
                labelPadding: EdgeInsets.only(right: 15),
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                isScrollable: true,
                indicator: UnderlineTabIndicator(),
                labelColor: Colors.black,
                labelStyle:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.black45,
                unselectedLabelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                tabs: List.generate(sourceList.length,
                    (index) => Text(sourceList[index].name.toString())),
              ),
            ))
          ];
        },
        body: Container(
          child: TabBarView(
            controller: _tabController,
            children: List.generate(sourceList.length,
                (index) => NewsCardList(sourceList[index].id.toString())),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15),
        ));
  }
}
