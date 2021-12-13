import 'dart:convert';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/model/branch_model.dart';
import 'package:bima_finance/core/model/news_model.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class NewsDetailView extends StatefulWidget {
  NewsModel? data;

  NewsDetailView({
    Key? key,
    required this.data
  });

  @override
  _NewsDetailViewState createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  Uint8List? image;

  @override
  void initState() {
   image = Base64Codec().decode(widget.data!.news_images!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(image!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)
                        )
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.data!.news_title}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text(widget.data!.created_date!, style: TextStyle(fontSize: 14,)),
                  SizedBox(height: 20,),
                  Html(
                    data: """
                      ${widget.data!.news_description}
                      """,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
