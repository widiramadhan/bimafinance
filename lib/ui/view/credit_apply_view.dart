import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/regex_rule.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/credit_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/credit_apply_result_view.dart';
import 'package:bima_finance/ui/view/credit_simulation_detail_view.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:bima_finance/ui/widget/more_field.dart';
import 'package:bima_finance/ui/widget/step_wizard_widget.dart';
import 'package:bima_finance/ui/widget/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
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
  String? phoneNumber;
  String? motherName;
  String? emergencyContact;
  File? ktpPhoto;
  File? selfiePhoto;
  String? companyName;
  String? companyPhone;
  String? companyAddress;
  int? job;
  int? sallary;
  int? branch;


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
    required this.phoneNumber,
    required this.motherName,
    required this.emergencyContact,
    required this.ktpPhoto,
    required this.selfiePhoto,
    required this.companyName,
    required this.companyPhone,
    required this.companyAddress,
    required this.job,
    required this.sallary});

  @override
  _CreditApplyViewState createState() => _CreditApplyViewState();
}

class _CreditApplyViewState extends State<CreditApplyView> {
  final price = MoneyMaskedTextController(decimalSeparator: '', thousandSeparator: '.', initialValue: 0, precision: 0);
  final dp = MoneyMaskedTextController(decimalSeparator: '', thousandSeparator: '.', initialValue: 0, precision: 0);
  String? tenor;
  String? amount = "0";
  int? productId;
  int? branchId;

  List<String> listTenor = [
    '6',
    '12',
    '18',
    '24',
    '36'
  ];

  List<String> jumlahPinjaman = [
    'Rp. 500.000',
    'Rp. 1.000.000',
    'Rp. 2.000.000',
    'Rp. 3.000.000',
    'Rp. 4.000.000',
    'Rp. 5.000.000',
    'Rp. 6.000.000',
    'Rp. 7.000.000',
    'Rp. 8.000.000',
    'Rp. 9.000.000',
    'Rp. 10.000.000',
  ];

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
                    active: true,
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
              await data.getProduct(context);
              await data.getTenor(context);
              await data.getBranch(context);
            },
            builder: (context, data, child) {
              return ModalProgress(
                inAsyncCall: data.state == ViewState.Busy ? true : false,
                child: data.product == null || data.tenor == null || data.branch == null ? Center(
                    child: CircularProgressIndicator()) : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MoreField(
                          labelText: 'Tipe Pembiayaan',
                          hint: Text(
                              'Pilih Pembiayaan',
                              style: TextStyle(
                                color: Colors.grey,)
                          ),
                          items: data.product!.map((e) =>
                              DropdownMenuItem(
                                child: Text(
                                  "${e.product_name}",
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: e.product_id,
                              )).toList(),
                          onChanged: (val) {
                            setState(() {
                              productId = int.parse(val.toString());
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
                        if(productId != 3) ...[
                          TextFieldWidget(
                            controller: price,
                            labelText: 'Harga Kendaraan',
                            hintText: 'Masukkan harga kendaraan',
                            textInputType: TextInputType.number,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ], 
                          ),
                        ] else ...[
                          MoreField(
                            labelText: 'Jumlah Pinjaman',
                            hint: Text(
                                'Pilih Jumlah Pinjaman',
                                style: TextStyle(
                                  color: Colors.grey,)
                            ),
                            items: jumlahPinjaman.map((e) =>
                                DropdownMenuItem(
                                  child: Text(
                                    "${e}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: e,
                                )).toList(),
                            onChanged: (val) {
                              setState(() {
                                amount = val.toString();
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
                        SizedBox(height: 20,),
                        MoreField(
                          labelText: 'Lama Kredit (dalam satuan bulan)',
                          hint: Text(
                              'Pilih Lama Kredit',
                              style: TextStyle(
                                color: Colors.grey,)
                          ),
                          items: data.tenor!.map((e) =>
                              DropdownMenuItem(
                                child: Text(
                                  "${e.tenor_value}",
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: e.tenor_id,
                              )).toList(),
                          onChanged: (val) {
                            setState(() {
                              tenor = val.toString();
                            });
                          },
                          validator: (val) {
                            if (val == null) {
                              return 'Wajib diisi';
                            }
                            return '';
                          },
                        ),
                        if(productId != 3) ...[
                          SizedBox(height: 20,),
                          TextFieldWidget(
                            controller: dp,
                            labelText: 'Uang Muka',
                            hintText: 'Masukkan uang muka',
                            textInputType: TextInputType.number,
                            onAction: TextInputAction.next,
                            maxLines: 1,
                            validation: [
                              RegexRule.emptyValidationRule,
                            ], 
                          ),
                          
                        ],
                        SizedBox(height: 20,),
                          MoreField(
                            labelText: 'Lokasi Cabang Pengajuan',
                            hint: Text(
                                'Pilih Cabang',
                                style: TextStyle(
                                  color: Colors.grey,)
                            ),
                            items: data.branch!.map((e) =>
                                DropdownMenuItem(
                                  child: Text(
                                    "${e.branch_name}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: e.branch_id,
                                )).toList(),
                            onChanged: (val) {
                              setState(() {
                                branchId = int.parse(val.toString());
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
                  ),
                ),
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
                if(productId == null || tenor == null || branchId == null){
                  Toast.show('Mohon lengkapi data', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                } else {
                  CreditViewModel data = new CreditViewModel();
                  var check = await data.simulationCredit(
                      productId!,
                      amount!,
                      price.text,
                      tenor!,
                      dp.text,
                      branchId!,
                      context);
                  if (check.instalment != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CreditApplyResultView(
                              data: check,
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
                              companyName: widget.companyName,
                              companyPhone: widget.companyPhone,
                              companyAddress: widget.companyAddress,
                              job: widget.job,
                              sallary: widget.sallary,
                              branch: widget.branch,
                            ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
    );
  }
}
