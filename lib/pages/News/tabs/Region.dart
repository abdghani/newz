import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newz/models/category.dart';
import 'package:newz/models/regions.dart';
import 'package:newz/pages/News/bloc/channels_bloc.dart';
import 'package:newz/pages/News/component/filterRegion.dart';
import 'package:newz/pages/News/component/regionNewsList.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newz/resuable/circleTabIndicator.dart';

class Region extends StatefulWidget {
  @override
  _RegionState createState() => _RegionState();
}

class _RegionState extends State<Region> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  late ChannelsBloc channelsBloc;

  Regions seletecRegion = regionList[0];
  String selectedCategory = 'general';

  _smoothScrollToTop() {
    _scrollController.animateTo(kToolbarHeight,
        duration: Duration(microseconds: 300), curve: Curves.ease);
    // fetchNews(regionList[_tabController.index].code);
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
    _tabController = TabController(length: regionList.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
    channelsBloc = BlocProvider.of<ChannelsBloc>(context);
    channelsBloc
        .add(GetRegionNews(seletecRegion.code.toString(), selectedCategory));
  }

  // fetching news from bloc
  fetchNews() {
    channelsBloc
        .add(GetRegionNews(seletecRegion.code.toString(), selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    showFilter() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => FilterRegion()).then((value) {
        if (value != null) {
          setState(() {
            selectedCategory = value;
          });
          fetchNews();
        }
      });
    }

    WidgetRegNameCard(reg) {
      String imgLink = 'assets/images/flags/' + reg.code.toString() + '.svg';
      return Opacity(
        opacity: 1,
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
            Text(reg.country.toString())
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
                title: Column(
                  children: [
                    TabBar(
                      onTap: (index) {
                        setState(() {
                          seletecRegion = regionList[index];
                        });
                        fetchNews();
                      },
                      indicator: CircleTabIndicator(
                          color: Theme.of(context).primaryColor, radius: 0),
                      labelPadding: EdgeInsets.only(right: 15, top: 10),
                      indicatorColor: Theme.of(context).accentColor,
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
                      tabs: List.generate(regionList.length,
                          (index) => WidgetRegNameCard(regionList[index])),
                    ),
                    GestureDetector(
                      onTap: showFilter,
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            toBeginningOfSentenceCase(selectedCategory)
                                .toString(),
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                toolbarHeight: 80,
                floating: true,
                pinned: true,
                expandedHeight: 12.0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body: Container(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(regionList.length,
                  (index) => RegionNewsList(regionList[index].code.toString())),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15),
          )),
    );
  }
}
