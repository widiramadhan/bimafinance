import 'dart:convert';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/helper/app_helper.dart';
import 'package:bima_finance/core/model/promo_model.dart';
import 'package:bima_finance/core/viewmodel/promo_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/promo_detail_view.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:bima_finance/ui/widget/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class PromoView extends StatefulWidget {
  @override
  _PromoViewState createState() => _PromoViewState();
}

class _PromoViewState extends State<PromoView> {
  String _text = "";
  List<PromoModel>? promo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promo Menarik", style: TextStyle(color: colorPrimary),),
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
      body: BaseView<PromoViewModel>(
        onModelReady: (data) async {
          await data.getPromo(context);
          if(data.promo!.isNotEmpty) {
            promo = data.promo;
          }
        },
        builder: (context, data, child) {
          return ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: data.promo == null ? Center(
              child: CircularProgressIndicator()) : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldWidget(
                        hintText: 'Cari Promo',
                        radius: 50,
                        maxLines: 1,
                        onChange: (value) {
                          setState(() {
                            _text = value;
                            promo = data.promo!.where((element) => element.promo_title!.toUpperCase().contains(_text.toUpperCase())).toList();
                          });
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              promo = data.promo!.where((element) => element.promo_title!.toUpperCase().contains(_text.toUpperCase())).toList();
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
                      promo!.isEmpty ? Center(child: Text("Data Tidak Ditemukan")) : ListView.builder(
                          shrinkWrap: true,
                          itemCount: promo!.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Uint8List? image;
                            if(promo![index].promo_images! !=null ) {
                              image = Base64Codec().decode(promo![index].promo_images!);
                            }
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PromoDetailView(data: promo![index]),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 20),
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
                                      decoration: promo![index].promo_images! != null ? BoxDecoration(
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
                                            topLeft: Radius.circular(10)
                                        ),
                                        color: Colors.grey[300]
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${promo![index].promo_title}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5,),
                                          Text(
                                            "${AppHelper.parseHtmlString(promo![index].promo_description!)}",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          )
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
                )
              )
            );
          }
        ),
      );
  }
}
