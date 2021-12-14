import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/view/ocr_view.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OCRGuideView extends StatefulWidget {
  @override
  _OCRGuideViewState createState() => _OCRGuideViewState();
}

class _OCRGuideViewState extends State<OCRGuideView> {
  bool isLogin = false;
  bool checked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Image.asset("assets/images/sampleCaptureKTP.png", width: 200,),
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
          height: 120,
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
              GestureDetector(
                  onTap: () {
                    if(checked == false) {
                      setState(() {
                        checked = true;
                      });
                    }else{
                      setState(() {
                        checked = false;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: checked,
                          checkColor: Colors.white,
                          activeColor: colorPrimary,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity(vertical : -4, horizontal: -4),
                          onChanged: (value) async {
                            if(checked == false) {
                              setState(() {
                                checked = true;
                              });
                            }else{
                              setState(() {
                                checked = false;
                              });
                            }
                          }
                      ),
                      //SizedBox(width: cb.Get.width * 0.05),
                      SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          "Dengan melanjutkan proses ini saya mengetahui dan menyetujui proses verifikasi dan digitalisasi identitas yang diberikan",//DigitalIdLang.verificationGuideDetailText.tr,
                          style: TextStyle(
                            color: Color(0xff3f4144),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 10,),
              ButtonTheme(
                disabledColor: Colors.grey,
                minWidth: MediaQuery.of(context).size.width,
                child: RaisedGradientButton(
                  gradient: LinearGradient(
                    colors: <Color>[
                      checked == false ? Colors.grey : colorPrimary,
                      checked == false ? Colors.grey : colorPrimary
                    ],
                  ),
                  onPressed: checked == false ? (){} : () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OCRView(),
                      ),
                    );
                  },
                  child: Text(
                    "AMBIL FOTO",
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
