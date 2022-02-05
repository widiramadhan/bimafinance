import 'dart:convert';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/model/branch_model.dart';
import 'package:bima_finance/core/model/news_model.dart';
import 'package:bima_finance/core/model/promo_model.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class PromoDetailView extends StatefulWidget {
  PromoModel? data;

  PromoDetailView({
    Key? key,
    required this.data
  });

  @override
  _PromoDetailViewState createState() => _PromoDetailViewState();
}

class _PromoDetailViewState extends State<PromoDetailView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promo Menarik", style: TextStyle(color: colorPrimary),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 2.0,
        brightness: Brightness.light,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: colorPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.data!.promo_images!,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => new SkeletonAnimation(
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15),
                          ),
                        )
                    ),
                    errorWidget: (context, url, error) => new Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Icon(
                            Icons.error
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: colorSecondary,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text("${widget.data!.created_date}", style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  SizedBox(height: 20,),
                  Text("${widget.data!.promo_title}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Html(
                    data: """
                      ${widget.data!.promo_description}
                      """,
                  )
                ],
              ),
            )
      ),
    );
  }
}
