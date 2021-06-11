import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:newz/models/category.dart';
import 'package:newz/models/regions.dart';
import 'package:newz/models/sources.dart';
import 'package:intl/intl.dart';

class FilterCategory extends StatefulWidget {
  @override
  _FilterCategoryState createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    closeModal({value}) {
      Navigator.pop(context, value);
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
                      Text(
                        'Regions',
                        style: TextStyle(color: Colors.black),
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
                    delegate: SliverChildBuilderDelegate((context, _) {
                  return Tags(
                    itemCount: categoryList.length,
                    itemBuilder: (index) {
                      return GestureDetector(
                        onTap: () => closeModal(
                            value: categoryList[index].name.toString()),
                        child: Chip(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          label: Text(categoryList[index].name.toString()),
                        ),
                      );
                    },
                  );
                }, childCount: 1))
              ],
            ),
          )),
    );
  }
}
