import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/view/branch_view.dart';
import 'package:bima_finance/ui/view/credit_apply.dart';
import 'package:bima_finance/ui/view/credit_simulation_view.dart';
import 'package:bima_finance/ui/view/job_view.dart';
import 'package:bima_finance/ui/view/news_view.dart';
import 'package:bima_finance/ui/view/ocr_guide_view.dart';
import 'package:bima_finance/ui/view/payment_view.dart';
import 'package:bima_finance/ui/view/product_view.dart';
import 'package:bima_finance/ui/view/promo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<ScaffoldState> _homeKey = new GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          elevation: 0,
          brightness: Brightness.dark,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff285fa9),
                  Color(0xff11458b)
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff285fa9),
                            Color(0xff11458b)
                          ]
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    FontAwesomeIcons.bars,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    FontAwesomeIcons.bell,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/default_avatar.png", width: 60,),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello,",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  "Widi Ramadhan",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    height: 80,
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(top: 140, left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey[300]!)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.moneyBillAlt,
                                    color: colorPrimary,
                                    size: 12,
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    "Tagihan berjalan",
                                    style: TextStyle(
                                      color: colorPrimary,
                                      fontSize: 10
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "Rp. 765.000",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: colorPrimary)
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bima Point",
                                    style: TextStyle(
                                        color: colorPrimary,
                                        fontSize: 10
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Icon(
                                    FontAwesomeIcons.coins,
                                    color: colorPrimary,
                                    size: 12,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "Rp. 100.000",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: _tileMenu(FontAwesomeIcons.newspaper, "Berita", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsView(),
                              ),
                            );
                          }, context),
                        ),
                        Expanded(
                          flex: 1,
                          child: _tileMenu(FontAwesomeIcons.percent, "Promo", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PromoView(),
                              ),
                            );
                          }, context),
                        ),
                        Expanded(
                          flex: 1,
                          child: _tileMenu(FontAwesomeIcons.questionCircle, "Informasi\nProduk", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductView(),
                              ),
                            );
                          }, context),
                        ),
                        Expanded(
                          flex: 1,
                          child: _tileMenu(FontAwesomeIcons.creditCard, "Simulasi\nKredit", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreditSimulationView(),
                              ),
                            );
                          }, context),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: _tileMenu(FontAwesomeIcons.solidIdBadge, "Pengajuan\nKredit", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OCRGuideView(),
                              ),
                            );
                          }, context),
                        ),
                        Expanded(
                          flex: 1,
                          child: _tileMenu(FontAwesomeIcons.mapMarkerAlt, "Lokasi", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BranchView(),
                              ),
                            );
                          }, context),
                        ),
                        Expanded(
                          flex: 1,
                          child: _tileMenu(FontAwesomeIcons.userTie, "Karir", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobView(),
                              ),
                            );
                          }, context),
                        ),
                        Expanded(
                          flex: 1,
                          child: _tileMenu(FontAwesomeIcons.wallet, "Informasi\nPembayaran", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentView(),
                              ),
                            );
                          }, context),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Promo Menarik",
                            style: TextStyle(
                                color: colorPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Lihat Semua",
                              style: TextStyle(
                                  color: colorPrimary,
                                  fontSize: 12
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 100,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 250,
                              height: 120,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/promo_1.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Berita Terkini",
                            style: TextStyle(
                                color: colorPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Lihat Semua",
                              style: TextStyle(
                                  color: colorPrimary,
                                  fontSize: 12
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _tileMenu(IconData icon, String title, VoidCallback onTap, BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: colorPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(
              icon,
              color: colorPrimary,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "$title",
            style: TextStyle(
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
