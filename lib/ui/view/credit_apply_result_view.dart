import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/credit_model.dart';
import 'package:bima_finance/core/viewmodel/credit_viewmodel.dart';
import 'package:bima_finance/ui/view/auth_view.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/ocr_guide_view.dart';
import 'package:bima_finance/ui/view/success_view.dart';
import 'package:bima_finance/ui/widget/detail.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:bima_finance/ui/widget/separator.dart';
import 'package:bima_finance/ui/widget/step_wizard_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditApplyResultView extends StatefulWidget {
  CreditModel? data;
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


  CreditApplyResultView({
    Key? key,
    required this.data,
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
    required this.sallary,
    required this.branch});


  @override
  _CreditApplyResultViewState createState() => _CreditApplyResultViewState();
}

class _CreditApplyResultViewState extends State<CreditApplyResultView> {
  final formatter = new NumberFormat("#,###");
  DateTime now = new DateTime.now();
  DateFormat date = new DateFormat('yyyy-MM-dd');
  String? formattedDate;


  @override
  void initState() {
    formattedDate = date.format(now);
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

        },
        builder: (context, data, child) {
          return ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      color: Color(0xfff5f6f8),
                      child: Text(
                        "DATA PEMOHON",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailWidget(
                              title: "NIK",
                              subtitle: "${widget.nik}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Nama",
                              subtitle: "${widget.name}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Tanggal Lahir",
                              subtitle: "${widget.dob}"
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      color: Color(0xfff5f6f8),
                      child: Text(
                        "DATA PENGAJUAN",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailWidget(
                              title: "Tanggal Pengajuan",
                              subtitle: "${formattedDate}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Tipe Pembiayaan",
                              subtitle: "${widget.data!.product_name}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: widget.data!.product_id != 3
                                  ? "Harga Kendaraan"
                                  : "Jumlah Pinjaman",
                              subtitle: widget.data!.product_id != 3
                                  ? "Rp. ${formatter.format(
                                  widget.data!.price)} "
                                  : "Rp. ${formatter.format(
                                  widget.data!.loan_amount)}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Jangka Waktu",
                              subtitle: "${widget.data!.tenor}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Uang Muka",
                              subtitle: "Rp. ${formatter.format(
                                  widget.data!.dp)}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Cicilan Perbulan",
                              subtitle: "Rp. ${formatter.format(
                                  widget.data!.instalment)}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Cabang Pengajuan",
                              subtitle: "${widget.data!.branch_name}"
                          ),
                          SeparatorWidget(),
                        ],
                      ),
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
          text: "AJUKAN KREDIT",
          color: colorPrimary,
          textColor: Colors.white,
          radius: 20,
          onPressed: () async {
            CreditViewModel model = new CreditViewModel();
            var success = await model.applyCredit(
                widget.nik,
                widget.dob,
                widget.gender,
                widget.address,
                widget.phoneNumber,
                widget.motherName,
                widget.emergencyContact,
                widget.province,
                widget.city,
                widget.subDistrict,
                widget.postalCode,
                widget.ktpPhoto,
                widget.selfiePhoto,
                widget.companyName,
                widget.companyPhone,
                widget.companyAddress,
                widget.job,
                widget.sallary,
                widget.data!.product_id,
                widget.data!.product_id != 3 ? widget.data!.price : widget.data!.loan_amount,
                widget.data!.tenor,
                widget.data!.dp,
                widget.data!.interest_per_month,
                widget.data!.total_interest,
                widget.data!.total_debt,
                widget.data!.instalment,
                widget.data!.branch_id,
                context);
            if(success == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SuccessView(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
