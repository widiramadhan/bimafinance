import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/credit_model.dart';
import 'package:bima_finance/core/viewmodel/credit_viewmodel.dart';
import 'package:bima_finance/ui/view/auth_view.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/ocr_guide_view.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:bima_finance/ui/widget/separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditSimulationDetailView extends StatefulWidget {
  CreditModel? data;

  CreditSimulationDetailView({Key? key, required this.data});

  @override
  _CreditSimulationDetailViewState createState() => _CreditSimulationDetailViewState();
}

class _CreditSimulationDetailViewState extends State<CreditSimulationDetailView> {
  final formatter = new NumberFormat("#,###");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simulasi Kredit", style: TextStyle(color: colorPrimary),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
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
                        _header("Tipe Pembiayaan", "${widget.data!.product_name}", context),
                        SizedBox(width: 10,),
                        widget.data!.product_id != 3 ? _header("Harga Kendaraan", "Rp. ${widget.data!.price}", context) : _header("Jumlah Pinjaman", "Rp. ${widget.data!.loan_amount}", context),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header("Jangka Waktu", "${widget.data!.tenor} Bulan", context),
                        SizedBox(width: 10,),
                        _header("Uang Muka", "Rp. ${widget.data!.product_id != 3 ? widget.data!.dp : 0}", context),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: Colors.grey[300]!)
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            color: colorPrimary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Bulan",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Cicilan",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          ListView.builder(
                            itemCount: widget.data!.data_instalment!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Text(
                                              "${widget.data!.data_instalment![index].month}"
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                              "Rp. ${widget.data!.data_instalment![index].instalment}"
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SeparatorWidget(height: 3,)
                                ],
                              );
                            }
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: MainButton(
          text: "PENGAJUAN KREDIT",
          color: colorPrimary,
          textColor: Colors.white,
          radius: 20,
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
        ),
      ),
    );
  }

  Widget _header(String title, String subtitle, BuildContext context){
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
              color: Colors.grey
            ),
          ),
          SizedBox(height: 5,),
          Text(
            "$subtitle",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorPrimary
            ),
          ),
        ],
      ),
    );
  }
}
