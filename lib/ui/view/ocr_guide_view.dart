import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/view/credit_apply.dart';
import 'package:bima_finance/ui/view/ocr_view.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:bima_finance/ui/widget/textfield_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class OCRGuideView extends StatefulWidget {
  @override
  _OCRGuideViewState createState() => _OCRGuideViewState();
}

class _OCRGuideViewState extends State<OCRGuideView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Panduan OCR", style: TextStyle(color: colorPrimary),),
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
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Ambil foto E-KTP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Posisikan E-KTP kamu dalam kotak dan\npastikan dapat terbaca dengan jelas",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30,),
                Image.asset("assets/images/sampleCaptureKTP.png", width: 250,),
                SizedBox(height: 30,),
                Text(
                  "Panduan Foto E-KTP",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Posisikan E-KTP di dalam area foto\ndan pastikan dalam pencahayaan yang baik",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 60,
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width,
            child: RaisedGradientButton(
              gradient: LinearGradient(
                colors: <Color>[
                  colorPrimary,
                  colorPrimary
                ],
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreditApplyView(),
                  ),
                );
              },
              child: Text(
                "Ambil Foto",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ),
      )
    );
  }
}
