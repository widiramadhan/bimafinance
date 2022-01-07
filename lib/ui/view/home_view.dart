import 'dart:convert';
import 'dart:typed_data';

import 'package:badges/badges.dart';
import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/helper/app_helper.dart';
import 'package:bima_finance/core/viewmodel/home_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/branch_view.dart';
import 'package:bima_finance/ui/view/contract_view.dart';
import 'package:bima_finance/ui/view/credit_simulation_view.dart';
import 'package:bima_finance/ui/view/career_view.dart';
import 'package:bima_finance/ui/view/login_view.dart';
import 'package:bima_finance/ui/view/news_detail_view.dart';
import 'package:bima_finance/ui/view/news_view.dart';
import 'package:bima_finance/ui/view/notification_view.dart';
import 'package:bima_finance/ui/view/ocr_guide_view.dart';
import 'package:bima_finance/ui/view/payment_view.dart';
import 'package:bima_finance/ui/view/photo_viewer_view.dart';
import 'package:bima_finance/ui/view/product_view.dart';
import 'package:bima_finance/ui/view/promo_detail_view.dart';
import 'package:bima_finance/ui/view/promo_view.dart';
import 'package:bima_finance/ui/view/register_view.dart';
import 'package:bima_finance/ui/widget/dialog_question.dart';
import 'package:bima_finance/ui/widget/dialog_success.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController scrollController = ScrollController();

  bool isLogin = false;
  String? name = "";
  String? email = "";

  Future<bool> checkSessionLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('is_login') ?? false;

    if(isLogin == true) {
      setState(() {
        name = prefs.getString('name');
        email = prefs.getString('email');
      });
    }
    return isLogin;
  }

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
          backgroundColor: Color(0xff07318b),
        ),
      ),
      //extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: checkSessionLogin(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return BaseView<HomeViewModel>(
                    onModelReady: (data) async {
                      data.init(context);
                    },
                    builder: (context, data, child) {
                      return ModalProgress(
                      inAsyncCall: data.state == ViewState.Busy ? true : false,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          data.init(context);
                        },
                        child: SingleChildScrollView(
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
                                      height: 150,
                                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30)
                                        ),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/bg_header.png"
                                            ),
                                            fit: BoxFit.cover
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              data.user == null ? Image.asset("assets/images/default_avatar.png", fit: BoxFit.cover, width: 60, height: 60,) :
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PhotoViewerView(path: data.user!.url_images),
                                                      )
                                                  );
                                                },
                                                child: ClipOval(
                                                  child: data.user!.url_images == null || data.user!.url_images == "" ? Image.asset("assets/images/default_avatar.png", fit: BoxFit.cover, width: 60, height: 60,) :
                                                  CachedNetworkImage(
                                                    imageUrl: data.user!.url_images!,
                                                    imageBuilder: (context, imageProvider) => Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(50)),
                                                        image: DecorationImage(
                                                            image: imageProvider, fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    placeholder: (context, url) => new SkeletonAnimation(
                                                        child: Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey[300],
                                                              borderRadius: BorderRadius.all(Radius.circular(50))
                                                          ),
                                                        )
                                                    ),
                                                    errorWidget: (context, url, error) => new Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey[300],
                                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                            Icons.error
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
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
                                                      isLogin == false ? "Dear" : "${data.user?.fullname == null ? "Dear" : data.user?.fullname}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              data.notification == null ? Icon(
                                                FontAwesomeIcons.bell,
                                                color: Colors.white,
                                              ) :
                                              IconButton(
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            NotificationView(),
                                                      )
                                                  ).then((value) async {
                                                    await data.getNotification(context);
                                                  });
                                                },
                                                icon: data.notification?.where((element) => element.notification_read == 1).toList().length == 0 ? Icon(
                                                  FontAwesomeIcons.bell,
                                                  color: Colors.white,
                                                ) : Badge(
                                                  badgeColor: Colors.red,
                                                  shape: BadgeShape.circle,
                                                  borderRadius: BorderRadius.circular(20),
                                                  padding: EdgeInsets.all(8),
                                                  toAnimate: false,
                                                  position: BadgePosition.topEnd(end: -15, top: -15),
                                                  badgeContent: Text("${data.notification?.where((element) => element.notification_read == 1).toList().length}", style: TextStyle(fontSize: 12, color: Colors.white),),
                                                  child: Icon(
                                                    FontAwesomeIcons.bell,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                                    // Container(
                                    //   width: double.infinity,
                                    //   height: 80,
                                    //   padding: EdgeInsets.all(16),
                                    //   margin: EdgeInsets.only(top: 140, left: 20, right: 20),
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.white,
                                    //       borderRadius: BorderRadius.circular(10),
                                    //       border: Border.all(width: 1, color: Colors.grey[300]!)
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.start,
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     children: [
                                    //       Expanded(
                                    //         flex: 1,
                                    //         child: Column(
                                    //           mainAxisAlignment: MainAxisAlignment.start,
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           children: [
                                    //             Row(
                                    //               mainAxisAlignment: MainAxisAlignment.start,
                                    //               crossAxisAlignment: CrossAxisAlignment.start,
                                    //               children: [
                                    //                 Icon(
                                    //                   FontAwesomeIcons.moneyBillAlt,
                                    //                   color: colorPrimary,
                                    //                   size: 12,
                                    //                 ),
                                    //                 SizedBox(width: 10,),
                                    //                 Text(
                                    //                   "Tagihan berjalan",
                                    //                   style: TextStyle(
                                    //                       color: colorPrimary,
                                    //                       fontSize: 10
                                    //                   ),
                                    //                 )
                                    //               ],
                                    //             ),
                                    //             SizedBox(height: 10,),
                                    //             Text(
                                    //               "Rp. 765.000",
                                    //               style: TextStyle(
                                    //                   color: Colors.black54,
                                    //                   fontWeight: FontWeight.bold,
                                    //                   fontSize: 16
                                    //               ),
                                    //             )
                                    //           ],
                                    //         ),
                                    //       ),
                                    //       Container(
                                    //         width: 1,
                                    //         height: 40,
                                    //         decoration: BoxDecoration(
                                    //             border: Border.all(width: 1, color: colorPrimary)
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //         flex: 1,
                                    //         child: Column(
                                    //           mainAxisAlignment: MainAxisAlignment.start,
                                    //           crossAxisAlignment: CrossAxisAlignment.end,
                                    //           children: [
                                    //             Row(
                                    //               mainAxisAlignment: MainAxisAlignment.end,
                                    //               crossAxisAlignment: CrossAxisAlignment.start,
                                    //               children: [
                                    //                 Text(
                                    //                   "Bima Point",
                                    //                   style: TextStyle(
                                    //                       color: colorPrimary,
                                    //                       fontSize: 10
                                    //                   ),
                                    //                 ),
                                    //                 SizedBox(width: 10,),
                                    //                 Icon(
                                    //                   FontAwesomeIcons.coins,
                                    //                   color: colorPrimary,
                                    //                   size: 12,
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //             SizedBox(height: 10,),
                                    //             Text(
                                    //               "Rp. 100.000",
                                    //               style: TextStyle(
                                    //                   color: Colors.black54,
                                    //                   fontWeight: FontWeight.bold,
                                    //                   fontSize: 16
                                    //               ),
                                    //             )
                                    //           ],
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    // )
                                  ],
                                ),
                                SizedBox(height: 20,),
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
                                            child: _tileMenu(FontAwesomeIcons.newspaper, "Berita\nTerkini", () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => NewsView(),
                                                ),
                                              );
                                            }, colorPrimary, context),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: _tileMenu(FontAwesomeIcons.percent, "Promo\nMenarik", () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => PromoView(),
                                                ),
                                              );
                                            }, Colors.orange, context),
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
                                            }, Colors.green, context),
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
                                            }, Colors.red, context),
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
                                              if(isLogin == false) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => LoginView(),
                                                  ),
                                                ).then((value) async {
                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                  if(prefs.getBool('is_login') == true){
                                                    data.getUser(context);
                                                    setState(() {
                                                      isLogin = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      isLogin = false;
                                                    });
                                                  }
                                                });
                                                //_showModalAuth(context);
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => OCRGuideView(),
                                                  ),
                                                );
                                              }
                                            }, Colors.red, context),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: _tileMenu(FontAwesomeIcons.mapMarkerAlt, "Kantor\nCabang", () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => BranchView(),
                                                ),
                                              );
                                            }, Colors.green, context),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: _tileMenu(FontAwesomeIcons.userTie, "Informasi\nKarir", () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => CareerView(),
                                                ),
                                              );
                                            }, Colors.orange, context),
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
                                            }, colorPrimary, context),
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
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => PromoView(),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Lihat Semua",
                                                  style: TextStyle(
                                                      color: colorPrimary,
                                                      fontSize: 12
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      data.promo == null ?
                                      Container(
                                        height: 100,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 3,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: EdgeInsets.only(right: 10),
                                                child: SkeletonAnimation(
                                                    child: Container(
                                                      height: 120,
                                                      width: 250,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey[300],
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                    )
                                                ),
                                              );
                                            }
                                        ),
                                      ) : Container(
                                        height: 100,
                                        child: data.promo!.isEmpty ? Center(child: Text("Data Tidak Ditemukan")) : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: data.promo!.length > 5 ? 5 : data.promo!.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => PromoDetailView(data: data.promo![index]),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(right: 10),
                                                  child: CachedNetworkImage(
                                                    imageUrl: data.promo![index].promo_images!,
                                                    imageBuilder: (context, imageProvider) => Container(
                                                      height: 120,
                                                      width: 250,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        image: DecorationImage(
                                                            image: imageProvider, fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    placeholder: (context, url) => new SkeletonAnimation(
                                                        child: Container(
                                                          height: 120,
                                                          width: 250,
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey[300],
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                        )
                                                    ),
                                                    errorWidget: (context, url, error) => new Container(
                                                      height: 120,
                                                      width: 250,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey[300],
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                            Icons.error
                                                        ),
                                                      ),
                                                    ),
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
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => NewsView(),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Lihat Semua",
                                                  style: TextStyle(
                                                      color: colorPrimary,
                                                      fontSize: 12
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      data.news == null ? Center(child: CircularProgressIndicator()) :
                                      data.news!.isEmpty ? Center(child: Text("Data Tidak Ditemukan")) : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data.news!.length > 5 ? 5 : data.news!.length,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index){
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => NewsDetailView(data: data.news![index]),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(bottom: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    CachedNetworkImage(
                                                      imageUrl: data.news![index].news_images!,
                                                      imageBuilder: (context, imageProvider) => Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              image: imageProvider, fit: BoxFit.cover),
                                                        ),
                                                      ),
                                                      placeholder: (context, url) => new SkeletonAnimation(
                                                          child: Container(
                                                            height: 100,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                                color: Colors.grey[300],
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                          )
                                                      ),
                                                      errorWidget: (context, url, error) => new Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey[300],
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                              Icons.error
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10,),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "${data.news![index].news_title}",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16,
                                                            ),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          SizedBox(height: 5,),
                                                          Text(
                                                            "${AppHelper.parseHtmlString(data.news![index].news_description!)}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                            maxLines: 3,
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
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                  "${data.news![index].created_date}",
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
                      )
                      );
                    }
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }

  Widget _tileMenu(IconData icon, String title, VoidCallback onTap, Color colors, BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: colors.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(
              icon,
              color: colors,
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

