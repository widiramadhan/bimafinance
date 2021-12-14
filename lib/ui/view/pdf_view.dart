import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PDFView extends StatelessWidget {
  String pathPDF = "";

  PDFView(this.pathPDF);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Text(
              //   "PDF",
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: Theme.of(context).accentColor,
              //   ),
              // ),
              // Text("Önizleme", style: TextStyle(color: Theme.of(context).accentTextTheme.subtitle.color, fontSize: 14)),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                //Share.share('$pathPDF');
              },
            ),
          ],
        ),
        //path: pathPDF
    );
  }
}