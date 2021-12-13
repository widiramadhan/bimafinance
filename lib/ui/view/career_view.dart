import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/career_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/career_detail_view.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class CareerView extends StatefulWidget {
  @override
  _CareerViewState createState() => _CareerViewState();
}

class _CareerViewState extends State<CareerView> {

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
      body: BaseView<CareerViewModel>(
        onModelReady: (data) async {
          await data.getCareer(context);
          },
        builder: (context, data, child) {
          return ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: data.career == null ? Center(
                child: CircularProgressIndicator()) : SingleChildScrollView(
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
                    data.career!.isEmpty ? Center(
                        child: Text("Data Tidak Ditemukan")) : ListView.builder(
                        itemCount: data.career!.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CareerDetailView(data: data.career![index]),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey[300]!, width: 1)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${data.career![index].career_title!.toUpperCase()}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "${data.career![index].created_date}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                ),
                                              ),
                                            ),
                                            // Align(
                                            //   alignment: Alignment.centerRight,
                                            //   child: Text(
                                            //     "16 kali dilihat",
                                            //     style: TextStyle(
                                            //         fontSize: 12,
                                            //         color: Colors.orange
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Icon(
                                    FontAwesomeIcons.chevronCircleRight,
                                    color: colorPrimary,
                                    size: 18,
                                  )
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
