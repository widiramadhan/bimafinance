import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/contract_model.dart';
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

class ContractDetailView extends StatefulWidget {
  ContractModel? data;

  ContractDetailView({
    Key? key,
    required this.data,});


  @override
  _ContractDetailViewState createState() => _ContractDetailViewState();
}

class _ContractDetailViewState extends State<ContractDetailView> {
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
        title: Text("Detail", style: TextStyle(color: colorPrimary),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2.0,
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Status Pengajuan",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                    "${widget.data!.statusName!.toLowerCase() == 'submission' ? 'Diajukan' : widget.data!.statusName!.toLowerCase() == 'on review' ? 'Sedang ditinjau' : widget.data!.statusName!.toLowerCase() == 'approved' ? 'Disetujui' : 'Ditolak'}",
                                    style: TextStyle(
                                      color:
                                      widget.data!.statusName!.toLowerCase() == 'submission' ? colorPrimary :
                                      widget.data!.statusName!.toLowerCase() == 'on review' ? colorSecondary :
                                      widget.data!.statusName!.toLowerCase() == 'approved' ? Colors.green :
                                      Colors.red,
                                    ),
                                ),
                              ),
                            ],
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Tanggal Pengajuan",
                              subtitle: "${widget.data!.dob}"
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
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
                              subtitle: "${widget.data!.nik}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Tanggal Lahir",
                              subtitle: "${widget.data!.dob}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Nomor Telepon",
                              subtitle: "${widget.data!.phoneNumber}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Nama Gadis Ibu Kandung",
                              subtitle: "${widget.data!.motherName}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Kontak Darurat",
                              subtitle: "${widget.data!.emergencyContact}"
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
                              subtitle: "${widget.data!.productName}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: widget.data!.productId != 3
                                  ? "Harga Kendaraan"
                                  : "Jumlah Pinjaman",
                              subtitle: widget.data!.productId != 3
                                  ? "Rp. ${formatter.format(
                                  widget.data!.amount)} "
                                  : "Rp. ${formatter.format(
                                  widget.data!.amount)}"
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
                                  widget.data!.downPayment)}"
                          ),
                          SeparatorWidget(),
                          DetailWidget(
                              title: "Cicilan Perbulan",
                              subtitle: "Rp. ${formatter.format(
                                  widget.data!.instalment)}"
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
    );
  }
}
