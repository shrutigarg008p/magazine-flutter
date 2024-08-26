import 'package:flutter/material.dart';
import 'package:graphics_news/Colors/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPage extends StatefulWidget {
  final String? url;

  const PdfPage({Key? key, this.url}) : super(key: key);

  @override
  _PdfPage createState() => _PdfPage();
}

class _PdfPage extends State<PdfPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: WidgetColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'PDF Viewer',
          style: TextStyle(
            color: WidgetColors.primaryColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: WidgetColors.primaryColor,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        '${widget.url}',
        key: _pdfViewerKey,
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        scrollDirection: PdfScrollDirection.horizontal,
        searchTextHighlightColor: Colors.red,
      ),
    );
  }
}
