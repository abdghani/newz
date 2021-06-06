import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:newz/models/sources.dart';
import 'package:intl/intl.dart';

class FilterState extends StatefulWidget {
  @override
  _FilterStateState createState() => _FilterStateState();
}

class _FilterStateState extends State<FilterState> {
  String sortField = 'category';
  Map<String, List<Sources>> filteredChannels = {};

  sortChannels(field) {
    filteredChannels = {};
    sourceList.forEach((source) {
      String fieldValue = source.toJson()[field].toString();
      if (filteredChannels[fieldValue] == null) {
        filteredChannels[fieldValue] = [source];
      } else {
        filteredChannels[fieldValue]!.add(source);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    sortChannels(sortField);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    closeModal({value}) {
      Navigator.pop(context, value);
    }

    Widget ChannelCard(name) {
      return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              name.toString().toUpperCase(),
              style: textTheme.headline5,
            ),
            Divider(),
            Tags(
              itemCount: filteredChannels[name]!.length,
              itemBuilder: (index) {
                return GestureDetector(
                  onTap: () => closeModal(
                      value: filteredChannels[name]![index].id.toString()),
                  child: Chip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    label: Text(filteredChannels[name]![index].name.toString()),
                  ),
                );
              },
            )
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Container(
                  // width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          focusColor: Colors.white,
                          style: textTheme.headline4,
                          iconEnabledColor: Colors.black,
                          value: sortField,
                          items: <String>['category', 'country', 'language']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 120,
                                child: Text(
                                  toBeginningOfSentenceCase(value).toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            sortChannels(value.toString());
                            setState(() {
                              sortField = value.toString();
                            });
                          },
                          // onChanged: onChangeDropdownItem,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: closeModal,
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                floating: true,
                pinned: true,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return ChannelCard(filteredChannels.keys.toList()[index]);
                }, childCount: filteredChannels.entries.length))
              ],
            ),
          )),
    );
  }
}
