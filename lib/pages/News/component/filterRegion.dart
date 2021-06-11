import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:newz/models/category.dart';
import 'package:newz/models/regions.dart';
import 'package:newz/models/sources.dart';
import 'package:intl/intl.dart';

class FilterRegion extends StatefulWidget {
  @override
  _FilterRegionState createState() => _FilterRegionState();
}

class _FilterRegionState extends State<FilterRegion> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String selectedCategory = 'general';
    List<String> categories = rawCat;
    final TextTheme textTheme = Theme.of(context).textTheme;

    closeModal({value}) {
      Navigator.pop(context, value);
    }

    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Select Category",
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 10),
            ...categories.map((cat) {
              return GestureDetector(
                onTap: () {
                  closeModal(value: cat);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        toBeginningOfSentenceCase(cat).toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Divider()
                    ],
                  ),
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
