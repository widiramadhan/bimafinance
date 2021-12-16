
import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/regex_rule.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/credit_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/liveness_view.dart';
import 'package:bima_finance/ui/view/work_information_view.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:bima_finance/ui/widget/step_wizard_widget.dart';
import 'package:bima_finance/ui/widget/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class VerificationView extends StatefulWidget {
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

  VerificationView({
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
  _VerificationViewState createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final _txtNik = TextEditingController();
  final _txtName = TextEditingController();
  final _txtDob = TextEditingController();
  final _txtGender = TextEditingController();
  final _txtAddress = TextEditingController();
  final _txtProvince = TextEditingController();
  final _txtCity = TextEditingController();
  final _txtSubDistrict = TextEditingController();
  final _txtPostalCode = TextEditingController();
  final _txtPhoneNumber = TextEditingController();
  final _txtMotherName = TextEditingController();
  final _txtEmergencyContact = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: StepWizardWidget(
                    active: true,
                    title: "Konfirmasi Data",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: StepWizardWidget(
                    active: false,
                    title: "Informasi Pekerjaan",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: StepWizardWidget(
                    active: false,
                    title: "Pengajuan Kredit",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: BaseView<CreditViewModel>(
          onModelReady: (data) async {

          },
          builder: (context, data, child) {
            return ModalProgress(
                inAsyncCall: data.state == ViewState.Busy ? true : false,
                child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: FileImage(widget.ktpPhoto!),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtNik,
                            labelText: 'NIK',
                            hintText: 'Masukkan NIK',
                            textInputType: TextInputType.number,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            enabled: false,
                            validation: [
                              RegexRule.emptyValidationRule,
                              RegexRule.nikValidationRule,
                              RegexRule.numberValidationRule
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtName,
                            labelText: 'Nama',
                            hintText: 'Masukkan Nama',
                            textInputType: TextInputType.text,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtDob,
                            labelText: 'Tanggal Lahir',
                            hintText: 'Masukkan Tanggal Lahir',
                            textInputType: TextInputType.text,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            enabled: false,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtGender,
                            labelText: 'Jenis Kelamin',
                            hintText: 'Masukkan Jenis Kelamin',
                            textInputType: TextInputType.text,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            enabled: false,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtAddress,
                            labelText: 'Alamat',
                            hintText: 'Masukkan Alamat Lengkap',
                            textInputType: TextInputType.text,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtSubDistrict,
                            labelText: 'Kecamatan',
                            hintText: 'Masukkan Kecamatan',
                            textInputType: TextInputType.text,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            enabled: false,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtCity,
                            labelText: 'Kota',
                            hintText: 'Masukkan Kota',
                            textInputType: TextInputType.text,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            enabled: false,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtProvince,
                            labelText: 'Provinsi',
                            hintText: 'Masukkan Provinsi',
                            textInputType: TextInputType.text,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            enabled: false,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtPostalCode,
                            labelText: 'Kode Pos',
                            hintText: 'Masukkan Kode Pos',
                            textInputType: TextInputType.text,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            enabled: false,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtPhoneNumber,
                            labelText: 'Nomor Telepon',
                            hintText: 'Masukkan Nomor Telepon',
                            textInputType: TextInputType.number,
                            onAction: TextInputAction.next,
                            maxLength: 15,
                            maxLines: 1,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtMotherName,
                            labelText: 'Nama Gadis Ibu Kandung',
                            hintText: 'Nama Gadis Ibu Kandung',
                            textInputType: TextInputType.text,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtEmergencyContact,
                            labelText: 'Nomor Kontak Darurat',
                            hintText: 'Masukkan Nomor Kontak Darurat',
                            textInputType: TextInputType.number,
                            onAction: TextInputAction.next,
                            maxLength: 15,
                            maxLines: 1,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                        ],
                      ),
                    )
                )
            );
          }
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: MainButton(
          text: "LANJUTKAN",
          color: colorPrimary,
          textColor: Colors.white,
          radius: 20,
          onPressed: () async {
            if(_txtName.text == "" || _txtAddress.text == "" || _txtPhoneNumber.text == "" || _txtMotherName.text == "" || _txtEmergencyContact.text == ""){
              Toast.show("Mohon lengkapi data anda", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }else{
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LivenessView(
                        nik: _txtNik.text,
                        name: _txtName.text,
                        dob: _txtDob.text,
                        gender: _txtGender.text,
                        address: _txtAddress.text,
                        province: _txtProvince.text,
                        city: _txtCity.text,
                        subDistrict: _txtSubDistrict.text,
                        postalCode: _txtPostalCode.text,
                        phoneNumber: _txtPhoneNumber.text,
                        motherName: _txtMotherName.text,
                        emergencyContact: _txtEmergencyContact.text,
                        ktpPhoto: widget.ktpPhoto,
                      ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}