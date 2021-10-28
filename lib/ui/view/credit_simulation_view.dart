import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/regex_rule.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/more_field.dart';
import 'package:bima_finance/ui/widget/textfield_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class CreditSimulationView extends StatefulWidget {
  @override
  _CreditSimulationViewState createState() => _CreditSimulationViewState();
}

class _CreditSimulationViewState extends State<CreditSimulationView> {

  List listPembiayaan = [
    {"value": "R2", "label": "R2 - Motor"},
    {"value": "R4", "label": "R4 - Mobil"},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Simulasi Kredit", style: TextStyle(color: colorPrimary),),
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
                    "Simulasikan Kredit Anda",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorPrimary
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Silahkan lakukan simulasi kredit dengan menggunakan form di bawah ini",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(height: 30,),
                  MoreField(
                    labelText: 'Tipe Pembiayaan',
                    hint: Text(
                        'Pilih Pembiayaan',
                        style: TextStyle(
                          color: Colors.grey,)
                    ),
                    // items: listPembiayaan.map((e) =>
                    //     DropdownMenuItem(
                    //       child: Text(
                    //         "${e.label}",
                    //         style: TextStyle(color: Colors.black),
                    //       ),
                    //       value: e.value,
                    //     )).toList(),
                    items: [],
                    onChanged: (val) {

                    },
                    validator: (val) {
                      if (val == null) {
                        return 'Wajib diisi';
                      }
                      return '';
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFieldWidget(
                    labelText: 'Harga Kendaraan',
                    hintText: 'Masukkan harga kendaraan',
                    textInputType: TextInputType.number,
                    onAction: TextInputAction.next,
                    maxLines: 1,
                    onChange: (value) {},
                    validation: [
                      RegexRule.emptyValidationRule,
                    ],
                  ),
                  SizedBox(height: 20,),
                  MoreField(
                    labelText: 'Lama Kredit',
                    hint: Text(
                        'Pilih Lama Kredit',
                        style: TextStyle(
                          color: Colors.grey,)
                    ),
                    // items: listPembiayaan.map((e) =>
                    //     DropdownMenuItem(
                    //       child: Text(
                    //         "${e.label}",
                    //         style: TextStyle(color: Colors.black),
                    //       ),
                    //       value: e.value,
                    //     )).toList(),
                    items: [],
                    onChanged: (val) {

                    },
                    validator: (val) {
                      if (val == null) {
                        return 'Wajib diisi';
                      }
                      return '';
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFieldWidget(
                    labelText: 'Uang Muka',
                    hintText: 'Masukkan uang muka',
                    textInputType: TextInputType.number,
                    onAction: TextInputAction.next,
                    maxLines: 1,
                    onChange: (value) {},
                    validation: [
                      RegexRule.emptyValidationRule,
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MainButton(
              text: "Cek Angsuran",
              color: colorPrimary,
              textColor: Colors.white,
              radius: 20,
              onPressed: () {},
            ),
          ),
        )
    );
  }
}
