import 'dart:convert';
import 'dart:typed_data';

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
import 'package:bima_finance/ui/view/ocr_guide_view.dart';
import 'package:bima_finance/ui/view/payment_view.dart';
import 'package:bima_finance/ui/view/product_view.dart';
import 'package:bima_finance/ui/view/promo_detail_view.dart';
import 'package:bima_finance/ui/view/promo_view.dart';
import 'package:bima_finance/ui/view/register_view.dart';
import 'package:bima_finance/ui/widget/dialog_question.dart';
import 'package:bima_finance/ui/widget/dialog_success.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      drawer: _drawerWidget(),
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
                                      height: 180,
                                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Scaffold.of(context).openDrawer();
                                                    },
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
                                          SizedBox(height: 40,),
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
                                                    isLogin == false ? "Dear" : "${data.user?.fullname == null ? "Dear" : data.user?.fullname}",
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
                                            }, context),
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
                                            }, context),
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
                                            }, context),
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
                                      data.promo == null ? Center(child: CircularProgressIndicator()) : Container(
                                        height: 100,
                                        child: data.promo!.isEmpty ? Center(child: Text("Data Tidak Ditemukan")) : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: data.promo!.length > 5 ? 5 : data.promo!.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              Uint8List? imagePromo;
                                              if(data.promo![index].promo_images! !=null ) {
                                                imagePromo = Base64Codec().decode(data.promo![index].promo_images!);
                                              }
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
                                                  width: 250,
                                                  height: 120,
                                                  margin: EdgeInsets.only(right: 10),
                                                  decoration: data.promo![index].promo_images! != null ? BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: Colors.grey[300]!, width: 1),
                                                    image: DecorationImage(
                                                      image: MemoryImage(imagePromo!),
                                                      fit: BoxFit.cover,
                                                      onError: (exception, stacktrace) {
                                                        print(exception.toString());
                                                        print(stacktrace.toString());
                                                      }
                                                    ),
                                                  ) : BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.grey[300]
                                                  ),
                                                  // child: Text(
                                                  //   "${data.promo![index].promo_images}",
                                                  //   overflow: TextOverflow.ellipsis,
                                                  //   maxLines: 1,
                                                  // ),
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
                                            Uint8List? imageNews;
                                            if(data.news![index].news_images! !=null ) {
                                              imageNews = Base64Codec().decode(data.news![index].news_images!);
                                            }
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
                                                    Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: data.news![index].news_images! != null ? BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Colors.grey[300]!, width: 1),
                                                        image: DecorationImage(
                                                          image: MemoryImage(imageNews!),
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

  Widget _drawerWidget(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          if(isLogin == true) ...[
            _drawerItem(
                icon: FontAwesomeIcons.fileContract,
                text: 'Daftar Kontrak',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContractView(isBack: true,),
                    ),
                  );
                }),
            _drawerItem(
                icon: FontAwesomeIcons.history,
                text: 'Riwayat Pembayaran',
                onTap: () {

                }),
            _drawerItem(
                icon: FontAwesomeIcons.creditCard,
                text: 'Simulasi Kredit',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreditSimulationView(),
                    ),
                  );
                }),
            _drawerItem(
                icon: FontAwesomeIcons.solidIdBadge,
                text: 'Pengajuan Kredit',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OCRGuideView(),
                    ),
                  );
                }),
            Divider(height: 25, thickness: 1),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
              child: Text("Akun",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  )),
            ),
            _drawerItem(
                icon: FontAwesomeIcons.idCard,
                text: 'Ubah Profil',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContractView(),
                    ),
                  );
                }),
            _drawerItem(
                icon: FontAwesomeIcons.lock,
                text: 'Ubah Kata Sandi',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContractView(),
                    ),
                  );
                }),
            _drawerItem(
              icon: FontAwesomeIcons.signOutAlt,
              text: 'Keluar',
              onTap: () {
                DialogQuestion(
                    context: context,
                    path: "assets/images/img_failed.png",
                    content: "Apakah anda yakin ingin keluar \ndari akun ini ?",
                    title: "Logout",
                    appName: "",
                    imageHeight: 100,
                    imageWidth: 100,
                    dialogHeight: 260,
                    buttonConfig: ButtonConfig(
                      dialogDone: "Yakin",
                      dialogCancel: "Batal",
                      buttonDoneColor: colorPrimary,
                    ),
                    submit: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('user_id');
                      prefs.remove('email');
                      prefs.remove('token');
                      prefs.remove('is_login');

                      SuccessDialog(
                        context: context,
                        title: "Sukses",
                        content: "Berhasil keluar dari akun",
                        imageHeight: 100,
                        imageWidth: 100,
                        dialogHeight: 260,
                      );
                      new Future.delayed(new Duration(seconds: 1), () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        HomeViewModel home = HomeViewModel();
                        home.init(context);
                      });
                    });
              },)
          ] else ...[
            _drawerItem(
                icon: FontAwesomeIcons.idCard,
                text: 'Daftar Akun',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterView(),
                    ),
                  ).then((value) async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    if(prefs.getBool('is_login') == true){
                      HomeViewModel model = new HomeViewModel();
                      model.getUser(context);
                      setState(() {
                        isLogin = true;
                      });
                    } else {
                      setState(() {
                        isLogin = false;
                      });
                    }
                  });
                }),
            _drawerItem(
                icon: FontAwesomeIcons.signInAlt,
                text: 'Login',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  ).then((value) async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    if(prefs.getBool('is_login') == true){
                      HomeViewModel model = new HomeViewModel();
                      model.getUser(context);
                      setState(() {
                        isLogin = true;
                      });
                    } else {
                      setState(() {
                        isLogin = false;
                      });
                    }
                  });
                }),
          ]
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: ClipOval(
        child: Image(
            image: AssetImage('assets/images/default_avatar.png'), fit: BoxFit.cover),
      ),
      accountName: Text('${name}'),
      accountEmail: Text('${email}'),
    );
  }

  Widget _drawerItem({IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              text!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

