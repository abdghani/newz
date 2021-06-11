import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:newz/models/category.dart';
import 'package:newz/pages/News/bloc/channels_bloc.dart';
import 'package:newz/pages/News/component/categoryNewsList.dart';
import 'package:newz/resuable/circleTabIndicator.dart';
import 'package:newz/util/preferences.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  late ChannelsBloc channelsBloc;

  _smoothScrollToTop() {
    _scrollController.animateTo(kToolbarHeight,
        duration: Duration(microseconds: 300), curve: Curves.ease);
    fetchNews(categoryList[_tabController.index].name);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: categoryList.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
    channelsBloc = BlocProvider.of<ChannelsBloc>(context);
    channelsBloc.add(GetCategoryNews(categoryList[0].name.toString()));
  }

  // fetching news from bloc
  fetchNews(String? code) {
    channelsBloc.add(GetCategoryNews(code.toString()));
  }

  @override
  Widget build(BuildContext context) {
    var prefProvider = Provider.of<PrefProvider>(context, listen: false);
    prefProvider.setInitialPreferences();

    getCatName(String name) {
      if (name == 'entertainment') {
        return 'Movies';
      }
      if (name == 'technology') {
        return 'Tech';
      }
      return toBeginningOfSentenceCase(name);
    }

    WidgetRegNameCard(reg) {
      String imgLink =
          'assets/images/categories/' + reg.name.toString() + '.svg';
      return Container(
        width: MediaQuery.of(context).size.width / 7,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: SvgPicture.asset(
                imgLink,
                semanticsLabel: 'Acme Logo',
                height: 30,
                width: 30,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(getCatName(reg.name).toString())
          ],
        ),
      );
    }

    return SafeArea(
      child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0,
                title: TabBar(
                    onTap: (index) {
                      fetchNews(categoryList[index].name);
                    },
                    indicator: CircleTabIndicator(
                        color: Theme.of(context).primaryColor, radius: 0),
                    labelPadding: EdgeInsets.only(right: 10, top: 10),
                    // indicatorColor: Theme.of(context).accentColor,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Theme.of(context).primaryColor,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                    unselectedLabelStyle: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                    unselectedLabelColor:
                        Theme.of(context).textTheme.subtitle2!.color,
                    tabs: List.generate(categoryList.length,
                        (index) => WidgetRegNameCard(categoryList[index]))),
                floating: true,
                pinned: true,
                toolbarHeight: 60,
                expandedHeight: 10.0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body: Container(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                  categoryList.length,
                  (index) =>
                      CategoryNewsList(categoryList[index].name.toString())),
              // (index) => Container()),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15),
          )),
    );
  }
}
