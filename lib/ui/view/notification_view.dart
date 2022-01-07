import 'dart:convert';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/home_viewmodel.dart';
import 'package:bima_finance/core/viewmodel/payment_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/payment_detail_view.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

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
      body: BaseView<HomeViewModel>(
        onModelReady: (data) async {
          await data.getNotification(context);
        },
        builder: (context, data, child) {
          return ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: data.notification == null ? Center(
                child: CircularProgressIndicator()) : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        data.notification!.isEmpty ? Container(
                          padding: EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Image.asset("assets/images/empty.png", width: 300,),
                                SizedBox(height: 30,),
                                Text("Notifikasi Anda kosong", style: TextStyle(fontSize: 16),)
                              ],
                            )
                          ) : ListView.builder(
                            itemCount: data.notification!.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: data.notification![index].notification_read == 0 ? null : () async {
                                  var update = await data.updateStatusNotification(data.notification![index].notification_id!, context);
                                  if(update == true){
                                    await data.getNotification(context);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: data.notification![index].notification_read == 1 ? colorPrimary.withOpacity(0.1) : Colors.white
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        data.notification![index].notification_read == 1 ? FontAwesomeIcons.solidEnvelope : FontAwesomeIcons.envelopeOpen,
                                        color: colorPrimary,
                                        size: 16,
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data.notification![index].notification_title}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Text(
                                              "${data.notification![index].notification_description}",
                                              style: TextStyle(
                                                  height: 1.5
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${data.notification![index].created_date}",
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
                                                //       "${data.notification![index].created_time}",
                                                //       style: TextStyle(
                                                //           height: 1.5
                                                //       ),
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        )
                      ],
                    ),
                  ),
            ),
          );
        }
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
