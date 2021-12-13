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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  Uint8List? image;

  @override
  void initState() {
   image = Base64Codec().decode(widget.data!.product_banner!);
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
