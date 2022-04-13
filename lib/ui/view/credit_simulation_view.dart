import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/regex_rule.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/credit_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/credit_simulation_detail_view.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:bima_finance/ui/widget/more_field.dart';
import 'package:bima_finance/ui/widget/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class CreditSimulationView extends StatefulWidget {
  @override
  _CreditSimulationViewState createState() => _CreditSimulationViewState();
}

class _CreditSimulationViewState extends State<CreditSimulationView> {
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
                        ]
                        else...[
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
                        ]
                          // SizedBox(height: 30,),
                        // MoreField(
                        //   labelText: 'Lokasi Cabang Pengajuan',
                        //   hint: Text(
                        //       'Lokasi Cabang Tersedia',
                        //       style: TextStyle(
                        //         color: Colors.grey,)
                        //   ),
                        //   items: data.branch!.map((e) =>
                        //       DropdownMenuItem(
                        //         child: Text(
                        //           "${e.branch_name}",
                        //           style: TextStyle(color: Colors.black),
                        //         ),
                        //         value: e.branch_id,
                        //       )).toList(),
                        //   onChanged: (val) {
                        //     setState(() {
                        //       branchId = int.parse(val.toString());
                        //     });
                        //   },
                        //   validator: (val) {
                        //     if (val == null) {
                        //       return 'Wajib diisi';
                        //     }
                        //     return '';
                        //   },
                        // ),
                          
                        ],
                        // SizedBox(height: 30,),
                        // Container(
                        //   height: 70,
                        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        //   child: MainButton(
                        //     text: "Cek Angsuran",
                        //     color: colorPrimary,
                        //     textColor: Colors.white,
                        //     radius: 20,
                        //     onPressed: () async {
                        //       var check = await data.simulationCredit(1, 1000000, 15000000, 24, 4500000, context);
                        //       print(check.instalment);
                        //       if(check.instalment != null) {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => CreditSimulationDetailView(
                        //               productId: productId,
                        //               data: check,
                        //             ),
                        //           ),
                        //         );
                        //       }
                        //     },
                        //   ),
                        // )
                      
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
              text: "CEK ANGSURAN",
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
                            CreditSimulationDetailView(
                              data: check,
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
