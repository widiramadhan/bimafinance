import 'dart:convert';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/model/branch_model.dart';
import 'package:bima_finance/core/model/news_model.dart';
import 'package:bima_finance/core/model/product_model.dart';
import 'package:bima_finance/ui/view/auth_view.dart';
import 'package:bima_finance/ui/view/ocr_guide_view.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class ProductDetailView extends StatefulWidget {
  ProductModel? data;

  ProductDetailView({
    Key? key,
    required this.data
  });

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.data!.product_banner!,
              imageBuilder: (context, imageProvider) => Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)
                  ),
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => new SkeletonAnimation(
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)
                        )
                    ),
                  )
              ),
              errorWidget: (context, url, error) => new Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)
                    )
                ),
                child: Center(
                  child: Icon(
                      Icons.error
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Html(
                    data: """
                      ${widget.data!.product_description}
                      """,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x80cacccf),
              offset: Offset(0, -1),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            ButtonTheme(
              disabledColor: Colors.grey,
              minWidth: MediaQuery.of(context).size.width,
              child: RaisedGradientButton(
                gradient: LinearGradient(
                  colors: <Color>[
                    colorPrimary,
                    colorPrimary
                  ],
                ),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  print(prefs.getBool('is_login'));
                  if(prefs.getBool('is_login') != true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthView(),
                      ),
                    ).then((value) {

                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OCRGuideView(),
                      ),
                    );
                  }
                },
                child: Text(
                  "PENGAJUAN KREDIT",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
