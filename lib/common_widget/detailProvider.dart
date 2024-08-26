import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:graphics_news/common_widget/download_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'download_alert.dart';

class DetailsProvider extends ChangeNotifier {
  bool loading = true;

  var dlDB = DownloadsDB();

  bool faved = false;
  bool downloaded = false;

  // check if book is favorited

  // check if book has been downloaded before
  checkDownload() async {
    List downloads = await dlDB.check({'id': "1"});
    if (downloads.isNotEmpty) {
      // check if book has been deleted
      String path = downloads[0]['path'];
      print(path);
      if (await File(path).exists()) {
        setDownloaded(true);
      } else {
        setDownloaded(false);
      }
    } else {
      setDownloaded(false);
    }
  }

  Future<List> getDownload() async {
    List c = await dlDB.check({'id': "1"});

    return c;
  }

  addDownload(Map body) async {
    await dlDB.removeAllWithId({'active': true,'id': "1"});
    await dlDB.add(body);
    checkDownload();
  }

  removeDownload() async {
    dlDB.remove({'active': true,'id': "1"}).then((v) {
      print(v);
      checkDownload();
    });
  }

  Future downloadFile(BuildContext context, String url, String filename) async {
    PermissionStatus? permissionStatus;
    // PermissionStatus _permissionStatus = PermissionStatus.granted;
    //
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      print("permision status ${status.isGranted}");
      await Permission.storage.request();
      print("permision status ${status.isGranted}");
      startDownload(context, url, filename);
    } else {
      startDownload(context, url, filename);
      print("permision status ${status.isGranted}");
    }
  }

  startDownload(BuildContext context, String url, String filename) async {
    Directory? appDocDir = Platform.isAndroid
        // ? await getApplicationSupportDirectory()
    ? await getTemporaryDirectory()
        : await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      Directory(appDocDir.path.split('Android')[0] + '${Constants.appName}')
          .createSync();
    }

    String path = Platform.isIOS
        ? appDocDir.path + '/$filename.epub'
        : appDocDir.path.split('Android')[0] +
            '${Constants.appName}/$filename.epub';
    print(path);
    File file = File(path);
    if (!await file.exists()) {
      await file.create();
    } else {
      await file.delete();
      await file.create();
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => DownloadAlert(
        url: url,
        path: path,
      ),
    ).then((v) {
      // When the download finishes, we then add the book
      // to our local database
      if (v != null) {
        addDownload(
          {
            'id': "1",
            'path': path,
          },
        );
      }
    });
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setFaved(value) {
    faved = value;
    notifyListeners();
  }

  void setDownloaded(value) {
    downloaded = value;
    notifyListeners();
  }
}
