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

class CreditApplyView extends StatefulWidget {
  @override
  _CreditApplyViewState createState() => _CreditApplyViewState();
}

class _CreditApplyViewState extends State<CreditApplyView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Pengajuan Kredit", style: TextStyle(color: colorPrimary),),
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
                    "Silahkan lakukan pengajuan kredit dengan menggunakan form di bawah ini",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFieldWidget(
                    labelText: 'Nama Lengkap',
                    hintText: 'Masukkan nama sesuai KTP',
                    textInputType: TextInputType.text,
                    onAction: TextInputAction.next,
                    maxLines: 1,
                    onChange: (value) {},
                    validation: [
                      RegexRule.emptyValidationRule,
                    ],
                  ),
                  SizedBox(height: 20,),
                  TextFieldWidget(
                    labelText: 'Nomor KTP',
                    hintText: 'Masukkan nomor KTP',
                    textInputType: TextInputType.number,
                    onAction: TextInputAction.next,
                    maxLines: 1,
                    maxLength: 16,
                    onChange: (value) {},
                    validation: [
                      RegexRule.emptyValidationRule,
                      RegexRule.nikValidationRule,
                    ],
                  ),
                  SizedBox(height: 20,),
                  TextFieldWidget(
                    labelText: 'Nomor Telepon',
                    hintText: 'Masukkan nomor telepon',
                    textInputType: TextInputType.number,
                    onAction: TextInputAction.next,
                    maxLines: 1,
                    maxLength: 15,
                    onChange: (value) {},
                    validation: [
                      RegexRule.emptyValidationRule,
                    ],
                  ),
                  SizedBox(height: 20,),
                  TextFieldWidget(
                    labelText: 'Alamat',
                    hintText: 'Masukkan alamat',
                    textInputType: TextInputType.text,
                    onAction: TextInputAction.next,
                    maxLines: 1,
                    onChange: (value) {},
                    validation: [
                      RegexRule.emptyValidationRule,
                    ],
                  ),
                  SizedBox(height: 20,),
                  MoreField(
                    labelText: 'Pekerjaan',
                    hint: Text(
                        'Pilih Pekerjaan',
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
                    labelText: 'Lama Bekerja',
                    hintText: 'Masukkan dalam tahun',
                    textInputType: TextInputType.number,
                    onAction: TextInputAction.next,
                    maxLines: 1,
                    maxLength: 3,
                    onChange: (value) {},
                    validation: [
                      RegexRule.emptyValidationRule,
                    ],
                  ),
                  SizedBox(height: 20,),
                  MoreField(
                    labelText: 'Tipe Pembiayaan',
                    hint: Text(
                        'Pilih tipe pembiayaan',
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
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MainButton(
              text: "Ajukan Sekarang",
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
