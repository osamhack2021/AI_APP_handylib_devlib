import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'dart:convert';

class EbookReader extends StatefulWidget {
  EbookReader({Key? key}) : super(key: key);

  @override
  _EbookReaderState createState() => _EbookReaderState();
}

class _EbookReaderState extends State<EbookReader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () async {
            EpubViewer.setConfig(
                themeColor: const Color(COLOR_PRIMARY),
                scrollDirection: EpubScrollDirection.HORIZONTAL,
                );
            await EpubViewer.openAsset('assets/ebooks/sample.epub');
            // // get current locator
            // EpubViewer.locatorStream.listen((locator) {
            //   print('LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
            // });
          },
          child: const Text('open epub'),
          
        ),
      ),
    );
  }
}
