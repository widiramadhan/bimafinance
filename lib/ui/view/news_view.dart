import 'dart:convert';
import 'dart:typed_data';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/helper/app_helper.dart';
import 'package:bima_finance/core/model/news_model.dart';
import 'package:bima_finance/core/viewmodel/news_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/news_detail_view.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:bima_finance/ui/widget/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:html/parser.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  String _text = "";
  List<NewsModel>? news;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Berita & Kegiatan", style: TextStyle(color: colorPrimary),),
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
      body: BaseView<NewsViewModel>(
        onModelReady: (data) async {
          await data.getNews(context);
          if(data.news!.isNotEmpty) {
            news = data.news;
          }
        },
        builder: (context, data, child) {
          return ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: data.news == null ? Center(
                child: CircularProgressIndicator()) : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldWidget(
                        hintText: 'Cari Berita',
                        radius: 50,
                        maxLines: 1,
                        onChange: (value) {
                          setState(() {
                            _text = value;
                            news = data.news!.where((element) => element.news_title!.toUpperCase().contains(_text.toUpperCase())).toList();
                          });
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                           setState(() {
                              news = data.news!.where((element) => element.news_title!.toUpperCase().contains(_text.toUpperCase())).toList();
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
                      news!.isEmpty ? Center(child: Text("Data Tidak Ditemukan")) : ListView.builder(
                          shrinkWrap: true,
                          itemCount: news!.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Uint8List? image;
                            if(news![index].news_images! !=null ) {
                              image = Base64Codec().decode(news![index].news_images!);
                            }
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailView(data: news![index]),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: news![index].news_images! !=null ? BoxDecoration(
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
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            "${news![index].news_title}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5,),
                                          Text(
                                            "${AppHelper.parseHtmlString(news![index].news_description!)}",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "by author",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              Align(
                                                alignment: Alignment
                                                    .centerRight,
                                                child: Text(
                                                  "${news![index].created_date}",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      )
                    ],
                  ),
                )
            ),
          );
        }
      ),
    );
  }
}
