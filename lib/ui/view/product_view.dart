import 'dart:convert';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/product_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/product_detail_view.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class ProductView extends StatefulWidget {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6f8),
      appBar: AppBar(
        title: Text("Produk & Layanan", style: TextStyle(color: colorPrimary),),
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
      body: BaseView<ProductViewModel>(
        onModelReady: (data) async {
          await data.getProduct(context);
        },
        builder: (context, data, child) {
          return ModalProgress(
              inAsyncCall: data.state == ViewState.Busy ? true : false,
              child: data.product == null ? Center(
                child: CircularProgressIndicator()) : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: data.product!.isEmpty ? Center(child: Text("Data Tidak Ditemukan")) : ListView.builder(
                      itemCount: data.product!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Uint8List? image;
                        if(data.product![index].product_thumbnail! !=null ) {
                          image = Base64Codec().decode(data.product![index].product_thumbnail!);
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailView(data: data.product![index]),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[300]!,
                                    width: 1)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 50,
                                  decoration: data.product![index].product_thumbnail! !=null ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: MemoryImage(image!),
                                      fit: BoxFit.cover,
                                    ),
                                  ) : BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[300]
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "${data.product![index].product_name}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Icon(
                                  FontAwesomeIcons.chevronCircleRight,
                                  color: colorPrimary,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    )
                  ),
              )
          );
        }
      ),
    );
  }
}
