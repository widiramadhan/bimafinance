import 'dart:convert';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/branch_model.dart';
import 'package:bima_finance/core/viewmodel/branch_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/branch_detail_view.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:bima_finance/ui/widget/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchView extends StatefulWidget {
  @override
  _BranchViewState createState() => _BranchViewState();
}

class _BranchViewState extends State<BranchView> {
  String _text = "";
  List<BranchModel>? branch;

  _launchMaps(double? latitude, double? longitude, BuildContext context) async {
    String googleUrl = 'comgooglemaps://?center=${latitude},${longitude}';
    String appleUrl = 'https://maps.apple.com/?sll=${latitude},${longitude}';

    if (await canLaunch("comgooglemaps://")) {
      print('launching com googleUrl');
      await launch(googleUrl);
    } else if (await canLaunch(appleUrl)) {
      print('launching apple url');
      await launch(appleUrl);
    } else {
      Toast.show("Could not launch maps, please install google maps", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      //throw 'Could not launch url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kantor Cabang", style: TextStyle(color: colorPrimary),),
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
      body: BaseView<BranchViewModel>(
        onModelReady: (data) async {
          await data.getBranch(context);
          if(data.branch!.isNotEmpty) {
            branch = data.branch;
          }
        },
        builder: (context, data, child) {
          return ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: data.branch == null ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      hintText: 'Cari Kantor Cabang',
                      radius: 50,
                      maxLines: 1,
                      onChange: (value) {
                        setState(() {
                          _text = value;
                          branch = data.branch!.where((element) => element.branch_name!.toUpperCase().contains(_text.toUpperCase())).toList();
                        });
                      },
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          setState(() {
                            branch = data.branch!.where((element) => element.branch_name!.toUpperCase().contains(_text.toUpperCase())).toList();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: colorPrimary,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    branch!.isEmpty ? Center(child: Text("Data Tidak Ditemukan")) : ListView.builder(
                        shrinkWrap: true,
                        itemCount: branch!.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Uint8List? image;
                          if(branch![index].branch_images !=null ) {
                             image = Base64Codec().decode(branch![index].branch_images!);
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BranchDetailView(data: branch![index]),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1, color: Colors.grey[300]!)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 120,
                                    decoration: branch![index].branch_images !=null ? BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)
                                      ),
                                      image: DecorationImage(
                                        image: MemoryImage(image!),
                                        fit: BoxFit.cover,
                                      ),
                                    ) : BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                    ),
                                    color: Colors.grey
                                  ),),
                                  SizedBox(height: 10,),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${branch![index].branch_name}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          "${branch![index].branch_address}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 20,),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: MainButton(
                                              text: "Lihat di Peta",
                                              onPressed: () {
                                                _launchMaps(branch![index].branch_latitude, branch![index].branch_longitude, context);
                                              },
                                              textColor: colorPrimary,
                                              borderColor: colorPrimary,
                                              color: Colors.white,
                                              radius: 10,
                                              width: 150,
                                              height: 30,
                                            )
                                        ),
                                        SizedBox(height: 10,),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
