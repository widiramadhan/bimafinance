import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/widget/textfield_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {

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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget(
                hintText: 'Cari Berita',
                radius: 50,
                suffixIcon: GestureDetector(
                  onTap: () {
                    Toast.show("Fitur ini belum tersedia", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
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
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () {
                        Toast.show("Fitur ini belum tersedia", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: /*state.newsModel[index].news_img_path == null
                                          ? Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage("assets/images/default_image.png"),
                                                fit: BoxFit.cover),
                                          ))
                                          :*/ Container(
                                  child: CachedNetworkImage(
                                    imageUrl: "http://www.bimafinance.co.id/wp-content/uploads/new14-b-768x540.jpg",
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                    placeholder: (context, url) => new SkeletonAnimation(
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                          ),
                                        )),
                                    errorWidget: (context, url, error) => new Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                      ),
                                      child: Center(
                                        child: Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "BIMA FINANCE RAIH PENGHARGAAN 2016",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    "Dalam event Indonesia Multifinance Award IV 2016 di Jakarta yang diadakan oleh Majalah Economic Review dan Perbanas Institute atas hasil kinerja di tahun 2015, Perusahaan berhasil meraih beberapa penghargaan sebagai berikut:",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "27 Oct 2021",
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
        ),
      ),
    );
  }
}
