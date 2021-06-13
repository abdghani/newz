import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newz/models/sources.dart';
import 'package:intl/intl.dart';
import 'package:newz/util/preferences.dart';
import 'package:provider/provider.dart';

class FilterChannel extends StatefulWidget {
  @override
  _FilterChannelState createState() => _FilterChannelState();
}

class _FilterChannelState extends State<FilterChannel> {
  String sortField = 'category';

  late List<Sources> filteredChannels;

  @override
  void initState() {
    super.initState();
    var prefProvider = Provider.of<PrefProvider>(context, listen: false);
    if (prefProvider.prefs['defaultEnglish'] == true) {
      filteredChannels = sourceList
          .where((Sources element) => element.language == 'en')
          .toList();
    } else {
      filteredChannels = sourceList;
    }
  }

  filterChannels(value) {
    String srch = value.toString().toLowerCase();
    List<Sources> temp = sourceList.where((_src) {
      return _src.name.toString().toLowerCase().indexOf(srch) != -1;
    }).toList();
    setState(() {
      filteredChannels = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    closeModal({value}) {
      Navigator.pop(context, value);
    }

    Widget getImage(String id) {
      String imgLink = 'assets/images/sources/' + id.toString();
      return ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          imgLink,
          height: 30,
          width: 30,
        ),
      );
    }

    Widget ChannelCard(Sources src) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: GestureDetector(
            onTap: () => closeModal(value: src.id.toString()),
            child: Column(
              children: [
                Row(children: [
                  getImage(src.id.toString()),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    src.name.toString(),
                    style: textTheme.headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ]),
                SizedBox(
                  height: 5,
                ),
                Text(
                  src.description.toString(),
                  style: textTheme.subtitle1!.copyWith(fontSize: 12),
                )
              ],
            )),
      );
    }

    return Container(
      color: Theme.of(context).backgroundColor,
      margin: EdgeInsets.only(top: 60),
      height: MediaQuery.of(context).size.height,
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Container(
                // color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 11,
                      child: TextField(
                        onChanged: filterChannels,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: 'Search channel.',
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: closeModal,
                          icon: Icon(Icons.close,
                              color: Theme.of(context).primaryColor)),
                    )
                  ],
                ),
              ),
              toolbarHeight: 55,
              backgroundColor: Theme.of(context).accentColor,
              floating: true,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...filteredChannels
                  .map((Sources _src) => ChannelCard(_src))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
