import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/regex_rule.dart';
import 'package:bima_finance/ui/view/liveness_view.dart';
import 'package:bima_finance/ui/widget/date_picker_field.dart';
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
  String? nik;
  String? name;
  String? dob;
  String? gender;
  String? address;
  String? province;
  String? city;
  String? subDistrict;
  String? postalCode;
  File? ktpPhoto;

  CreditApplyView({
    Key? key,
    required this.nik,
    required this.name,
    required this.dob,
    required this.gender,
    required this.address,
    required this.province,
    required this.city,
    required this.subDistrict,
    required this.postalCode,
    required this.ktpPhoto,
  });

  @override
  _CreditApplyViewState createState() => _CreditApplyViewState();
}

class _CreditApplyViewState extends State<CreditApplyView> {
  final _txtNik = TextEditingController();
  final _txtName = TextEditingController();
  final _txtDob = TextEditingController();
  final _txtGender = TextEditingController();
  final _txtAddress = TextEditingController();
  final _txtProvince = TextEditingController();
  final _txtCity = TextEditingController();
  final _txtSubDistrict = TextEditingController();
  final _txtPostalCode = TextEditingController();
  final _companyName = TextEditingController();
  final _sallary = TextEditingController();
  final _job = TextEditingController();

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  @override
  void initState() {
    _txtNik.text = widget.nik!;
    _txtName.text = widget.name!;
    _txtDob.text = widget.dob!;
    _txtGender.text = widget.gender!;
    _txtAddress.text = widget.address!;
    _txtProvince.text = widget.province!;
    _txtCity.text = widget.city!;
    _txtSubDistrict.text = widget.subDistrict!;
    _txtPostalCode.text = widget.postalCode!;
    super.initState();
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
    if(_currentStep == 2){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LivenessView(
            nik: _txtNik.text,
            name: _txtName.text,
            dob: _txtDob.text,
            gender: _txtGender.text,
            address: _txtAddress.text,
            province: _txtProvince.text,
            city: _txtCity.text,
            subDistrict: _txtSubDistrict.text,
            postalCode: _txtPostalCode.text,
            ktpPhoto: widget.ktpPhoto,
          ),
        ),
      );
    }
  }
  cancel() {
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Verifikasi Data", style: TextStyle(color: colorPrimary),),
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
          body: Container(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Theme(
                      data: ThemeData(
                        accentColor: colorPrimary,
                        primarySwatch: Colors.indigo,
                        colorScheme: ColorScheme.light(
                            primary: colorPrimary
                        )
                      ),
                      child: Stepper(
                        type: stepperType,
                        physics: ScrollPhysics(),
                        currentStep: _currentStep,
                        onStepTapped: (step) => tapped(step),
                        onStepContinue:  continued,
                        onStepCancel: cancel,
                        steps: <Step>[
                          Step(
                            title: new Text('Profil'),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Nomor KTP"),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: _txtNik,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan Nomor KTP',
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                  ),
                                ),
                                SizedBox(height: 16,),
                                Text("Nama Lengkap"),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: _txtName,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan Nama Lengkap',
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                  ),
                                ),
                                SizedBox(height: 16,),
                                Text("Tanggal Lahir"),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: _txtDob,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan Tanggal Lahir',
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                  ),
                                ),
                                SizedBox(height: 16,),
                                Text("Jenis Kelamin"),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: _txtGender,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan Jenis Kelamin',
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                  ),
                                ),
                              ],
                            ),
                            isActive: _currentStep >= 0,
                            state: _currentStep >= 0 ?
                            StepState.complete : StepState.disabled,
                          ),
                          Step(
                            title: new Text('Alamat'),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Alamat"),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: _txtAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan alamat',
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                ),
                                SizedBox(height: 16,),
                                Text("Provinsi"),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: _txtProvince,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan Provinsi',
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                ),
                                SizedBox(height: 16,),
                                Text("Kota"),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: _txtCity,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan kota',
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                ),
                                SizedBox(height: 16,),
                                Text("Kecamatan"),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: _txtSubDistrict,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan kecamatan',
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                ),
                                SizedBox(height: 16,),
                                Text("Kode Pos"),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: _txtPostalCode,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Masukkan kode pos',
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                ),
                              ],
                            ),
                            isActive: _currentStep >= 0,
                            state: _currentStep >= 1 ?
                            StepState.complete : StepState.disabled,
                          ),
                          Step(
                            title: new Text('Pekerjaan'),
                            content: Column(
                              children: <Widget>[
                                new TextFieldWidget(
                                  labelText: 'Nama Perusahaan',
                                  hintText: 'Masukkan nama perusahaan',
                                  textInputType: TextInputType.text,
                                  onAction: TextInputAction.next,
                                  maxLines: 1,
                                  onChange: (value) {
                                    setState(() {
                                      //postalCode = value;
                                    });
                                  },
                                  validation: [
                                    RegexRule.emptyValidationRule,
                                  ],
                                ),
                              ],
                            ),
                            isActive:_currentStep >= 0,
                            state: _currentStep >= 2 ?
                            StepState.complete : StepState.disabled,
                          ),
                        ],
                      )
                    )
                  ),
                ],
              ),
            ),
          ),
          // bottomNavigationBar: Container(
          //   height: 70,
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   child: MainButton(
          //     text: "Ajukan Sekarang",
          //     color: colorPrimary,
          //     textColor: Colors.white,
          //     radius: 20,
          //     onPressed: () {},
          //   ),
          // ),
        )
    );
  }
}
