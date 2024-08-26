import 'dart:convert';

import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

import 'detailProvider.dart';

class Details extends StatefulWidget {
  Details({
    Key? key,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buildDownloadReadButton(value, context)],
          ),
        );
      },
    );
  }

  openBook(DetailsProvider provider) async {
    List dlList = await provider.getDownload();
    if (dlList.isNotEmpty) {
      // dlList is a list of the downloads relating to this Book's id.
      // The list will only contain one item since we can only
      // download a book once. Then we use `dlList[0]` to choose the
      // first value from the string as out local book path
      Map dl = dlList[0];
      String path = dl['path'];

    //  List locators = await LocatorDB().getLocator("1");

      EpubViewer.setConfig(
        identifier: 'androidBook',
        themeColor: Colors.grey,
        scrollDirection: EpubScrollDirection.VERTICAL,
        enableTts: false,
        allowSharing: true,
      );
      EpubViewer.open(path,
          // lastLocation:
          //     locators.isNotEmpty ? EpubLocator.fromJson(locators[0]) : null
      );
      EpubViewer.locatorStream.listen((event) async {
        // Get locator here
        Map json = jsonDecode(event);
        json['bookId'] = "1";
        // Save locator to your database
       // await LocatorDB().update(json);
      });
    }
  }

  _buildDownloadReadButton(DetailsProvider provider, BuildContext context) {
    if (provider.downloaded) {
      return FlatButton(
        onPressed: () => openBook(provider),
        child: Text(
          'Read Book',
        ),
      );
    } else {
      return FlatButton(
        onPressed: () => provider.downloadFile(
          context,
          "http://gcgl.dci.in/public/storage/magazines/pdf-test.epub",
          "pdf-test",
        ),
        child: Text(
          'Download',
        ),
      );
    }
  }
}
