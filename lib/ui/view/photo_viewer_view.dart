
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerView extends StatelessWidget {
  String? path;

  PhotoViewerView({Key? key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("", style: TextStyle(color: Colors.green),),
            backgroundColor: Colors.black,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            brightness: Brightness.light,
            leading: IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: () => Navigator.of(context).pop(),
            )
        ),
        body: Container(
            child: PhotoView(
              imageProvider: NetworkImage(path!),
            )
        )
    );
  }
}
