import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/credit_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/contract_detail_view.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class ContractView extends StatefulWidget {
  bool? isBack;

  ContractView({
    Key? key,
    this.isBack = false
  });

  @override
  _ContractViewState createState() => _ContractViewState();
}

class _ContractViewState extends State<ContractView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kontrak", style: TextStyle(color: colorPrimary),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        brightness: Brightness.light,
        leading: widget.isBack == true ? GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: colorPrimary,
          ),
        ) : null,
        // bottom: TabBar(
        //   controller: _tabController,
        //   tabs: [
        //     Tab(
        //       child: Text('Pengajuan', style: TextStyle(color: colorPrimary),),
        //     ),
        //     Tab(
        //       child: Text('Aktif', style: TextStyle(color: colorPrimary),),
        //     ),
        //     Tab(
        //       child: Text('Tidak Aktif', style: TextStyle(color: colorPrimary),),
        //     ),
        //   ],
        // ),
      ),
      // body: TabBarView(
      //   controller: _tabController,
      //   children: [
      //     _tabView(context),
      //     SingleChildScrollView(child: Container(),),
      //     SingleChildScrollView(child: Container(),),
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   child: const Icon(Icons.add, color: Colors.white,),
      //   backgroundColor: colorPrimary,
      // ),
        body: BaseView<CreditViewModel>(
            onModelReady: (data) async {
              await data.getContract(context);
            },
            builder: (context, data, child) {
              return ModalProgress(
                inAsyncCall: data.state == ViewState.Busy ? true : false,
                child: data.contract == null ? Center(
                    child: CircularProgressIndicator()) : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        data.contract!.isEmpty ? Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Image.asset("assets/images/empty.png", width: 300,),
                                SizedBox(height: 30,),
                                Text("Data Anda masih kosong", style: TextStyle(fontSize: 16),)
                              ],
                            )
                        ) : ListView.builder(
                            itemCount: data.contract!.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContractDetailView(data: data.contract![index]),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[300]!, width: 1)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data.contract![index].appNo!.toUpperCase()}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${data.contract![index].createdDate}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color:
                                                        data.contract![index].statusName!.toLowerCase() == 'submission' ? colorPrimary :
                                                        data.contract![index].statusName!.toLowerCase() == 'on review' ? colorSecondary :
                                                        data.contract![index].statusName!.toLowerCase() == 'approved' ? Colors.green :
                                                        Colors.red,
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    child: Text(
                                                    "${data.contract![index].statusName!.toLowerCase() == 'submission' ? 'Diajukan' : data.contract![index].statusName!.toLowerCase() == 'on review' ? 'Sedang ditinjau' : data.contract![index].statusName!.toLowerCase() == 'approved' ? 'Disetujui' : 'Ditolak'}",
                                                    style: TextStyle(
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        )
    );
  }

  Widget _tabView(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ListView.builder(
              itemCount: 0,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!, width: 1)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#34901904021010",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Widi Ramadhan",
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Pembiayaan Multiguna",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: MainButton(
                                text: "Detail",
                                onPressed: null,
                                textColor: colorPrimary,
                                borderColor: colorPrimary,
                                color: Colors.white,
                                radius: 10,
                                width: 100,
                              )
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
