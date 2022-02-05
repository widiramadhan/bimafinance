
import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/regex_rule.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/credit_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/credit_apply_view.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:bima_finance/ui/widget/more_field.dart';
import 'package:bima_finance/ui/widget/step_wizard_widget.dart';
import 'package:bima_finance/ui/widget/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class WorkInformationView extends StatefulWidget {
  String? nik;
  String? name;
  String? dob;
  String? gender;
  String? address;
  String? province;
  String? city;
  String? subDistrict;
  String? postalCode;
  String? phoneNumber;
  String? motherName;
  String? emergencyContact;
  File? ktpPhoto;
  File? selfiePhoto;

  WorkInformationView({
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
    required this.phoneNumber,
    required this.motherName,
    required this.emergencyContact,
    required this.ktpPhoto,
    required this.selfiePhoto,
  });

  @override
  _WorkInformationViewState createState() => _WorkInformationViewState();
}

class _WorkInformationViewState extends State<WorkInformationView> {
  final _txtCompanyName = TextEditingController();
  final _txtCompanyPhone = TextEditingController();
  final _txtCompanyAddress = TextEditingController();
  int? _sallary;
  int? _job;

  @override
  void initState() {
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
                    active: true,
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
            await data.getJob(context);
            await data.getSallary(context);
          },
          builder: (context, data, child) {
            return ModalProgress(
                inAsyncCall: data.state == ViewState.Busy ? true : false,
                child: data.job == null || data.sallary == null ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldWidget(
                            controller: _txtCompanyName,
                            labelText: 'Nama Perusahaan',
                            hintText: 'Masukkan Nama Perusahaan',
                            textInputType: TextInputType.text,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                           
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtCompanyPhone,
                            labelText: 'Nomor Telepon Perusahaan',
                            hintText: 'Masukkan Nomor Telepon Perusahaan',
                            textInputType: TextInputType.number,
                            maxLength: 15,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                           
                            validation: [
                              RegexRule.emptyValidationRule,
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: _txtCompanyAddress,
                            labelText: 'Alamat Perusahaan',
                            hintText: 'Masukkan Alamat Perusahaan',
                            textInputType: TextInputType.text,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                           
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
                            items: data.job!.map((e) =>
                                DropdownMenuItem(
                                  child: Text(
                                    "${e.job_name}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: e.job_id,
                                )).toList(),
                            onChanged: (val) {
                              setState(() {
                                _job = int.parse(val.toString());
                              });
                            },
                            validator: (val) {
                              if (val == null) {
                                return 'Wajib diisi';
                              }
                              return '';
                            },
                          ),
                          SizedBox(height: 20,),
                          MoreField(
                            labelText: 'Gaji Perbulan',
                            hint: Text(
                                'Pilih Gaji Perbulan',
                                style: TextStyle(
                                  color: Colors.grey,)
                            ),
                            items: data.sallary!.map((e) =>
                                DropdownMenuItem(
                                  child: Text(
                                    "${e.sallary_title}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: e.sallary_id,
                                )).toList(),
                            onChanged: (val) {
                              setState(() {
                                _sallary = int.parse(val.toString());
                              });
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
            if(_txtCompanyName.text == "" || _txtCompanyPhone.text == "" || _txtCompanyAddress.text == "" || _job == null || _sallary == null){
              Toast.show("Mohon lengkapi data anda", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }else{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    CreditApplyView(
                      nik: widget.nik!,
                      name: widget.name!,
                      dob: widget.dob!,
                      gender: widget.gender!,
                      address: widget.address!,
                      province: widget.province!,
                      city: widget.city!,
                      subDistrict: widget.subDistrict!,
                      postalCode: widget.postalCode!,
                      phoneNumber: widget.phoneNumber!,
                      motherName: widget.motherName!,
                      emergencyContact: widget.emergencyContact,
                      ktpPhoto: widget.ktpPhoto,
                      selfiePhoto: widget.selfiePhoto,
                      companyName: _txtCompanyName.text,
                      companyPhone: _txtCompanyPhone.text,
                      companyAddress: _txtCompanyName.text,
                      job: _job,
                      sallary: _sallary,
                    ),
                  )
              );
            }
          },
        ),
      ),
    );
  }
}