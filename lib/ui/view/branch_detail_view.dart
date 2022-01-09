import 'dart:convert';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/model/branch_model.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class BranchDetailView extends StatefulWidget {
  BranchModel? data;

  BranchDetailView({
    Key? key,
    required this.data
  });

  @override
  _BranchDetailViewState createState() => _BranchDetailViewState();
}

class _BranchDetailViewState extends State<BranchDetailView> {
  _launchMaps(double? latitude, double? longitude, BuildContext context) async {
    String googleUrl = 'comgooglemaps://?center=${latitude},${longitude}';
    String appleUrl = 'https://maps.apple.com/?sll=${latitude},${longitude}';

    if (await canLaunch("comgooglemaps://")) {
      print('launching com googleUrl');
      await launch(googleUrl);
    } else if (await canLaunch(appleUrl)) {
      print('launching apple url');
      await launch(appleUrl);
    } else {
      Toast.show("Could not launch maps, please install google maps", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      //throw 'Could not launch url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kantor Cabang", style: TextStyle(color: colorPrimary),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
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
                imageUrl: widget.data!.branch_images!,
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
              Text("Kantor Cabang "+widget.data!.branch_name!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(widget.data!.branch_address!, style: TextStyle(fontSize: 14, height: 1.5)),
              SizedBox(height: 20,),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(widget.data!.branch_latitude!, widget.data!.branch_longitude!),
                    zoom: 13.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      attributionBuilder: (_) {
                        return Text("© OpenStreetMap contributors");
                      },
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(widget.data!.branch_latitude!, widget.data!.branch_longitude!),
                          builder: (ctx) =>
                              Container(
                                child: Icon(
                                  Icons.location_on,
                                  color: colorPrimary,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              MainButton(
                text: "Lihat di Peta",
                onPressed: () {
                  _launchMaps(widget.data!.branch_latitude, widget.data!.branch_longitude, context);
                },
                textColor: Colors.white,
                borderColor: colorSecondary,
                color: colorSecondary,
                radius: 50,
                width: double.infinity,
                height: 50,
              )
            ],
          ),
        )
      ),
    );
  }
}
