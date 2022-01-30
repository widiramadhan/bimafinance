import 'dart:convert';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/notification_model.dart';
import 'package:bima_finance/core/viewmodel/home_viewmodel.dart';
import 'package:bima_finance/core/viewmodel/payment_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/payment_detail_view.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationDetailView extends StatefulWidget {
  NotificationModel data;

  NotificationDetailView({Key? key, required this.data});

  @override
  _NotificationDetailViewState createState() => _NotificationDetailViewState();
}

class _NotificationDetailViewState extends State<NotificationDetailView> {

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
        title: Text("Notifikasi", style: TextStyle(color: colorPrimary),),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    FontAwesomeIcons.envelopeOpen,
                    color: colorPrimary,
                    size: 16,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "${widget.data.notification_title}",
                    style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${widget.data.created_date}",
                      style: TextStyle(
                          height: 1.5
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Text(
                  //       "${widget.data.created_time}",
                  //       style: TextStyle(
                  //           height: 1.5
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              SizedBox(height: 20,),
              Text(
                "${widget.data.notification_description}",
                style: TextStyle(
                    height: 1.5
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
