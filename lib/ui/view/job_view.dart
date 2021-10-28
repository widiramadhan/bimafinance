import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class JobView extends StatefulWidget {
  @override
  _JobViewState createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Karir", style: TextStyle(color: colorPrimary),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
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
              Text(
                "Peluang Karir",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorPrimary
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Mari bergabunglah bersama kami menjadi bagian dari Bima Finance: (Lokasi kerja akan disesuaikan dengan wilayah anda)",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                ),
              ),
              SizedBox(height: 20,),
              ListView.builder(
                  itemCount: 5,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!, width: 1)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Marketing Head",
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "8 hari yang lalu",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "16 kali dilihat",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange
                                    ),
                                  ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      )
    );
  }

  Widget _tabView(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ListView.builder(
              itemCount: 5,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!, width: 1)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#34901904021010",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Widi Ramadhan",
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Pembiayaan Multiguna",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: MainButton(
                                text: "Detail",
                                onPressed: null,
                                textColor: colorPrimary,
                                borderColor: colorPrimary,
                                color: Colors.white,
                                radius: 10,
                                width: 100,
                              )
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
