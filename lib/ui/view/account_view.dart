import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/viewmodel/account_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/login_view.dart';
import 'package:bima_finance/ui/widget/dialog_question.dart';
import 'package:bima_finance/ui/widget/dialog_success.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {

  @override
  void initState() {
    super.initState();
  }

  bool isLogin = false;

  Future<bool> checkSessionLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('is_login') ?? false;
    return isLogin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akun", style: TextStyle(color: colorPrimary),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        brightness: Brightness.light,
      ),
      body: FutureBuilder(
        future: checkSessionLogin(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return BaseView<AccountViewModel>(
                onModelReady: (data) async {
                  if(isLogin == true){
                    data.getUser(context);
                  }
                },
              builder: (context, data, child) {
                if(isLogin == true) {
                  if(data.user == null) {
                    return Center(child: CircularProgressIndicator(),);
                  } else {
                    return _profilePage(data, context);
                  }
                } else {
                  return _loginPage(data, context);
                }
              }
            );
          } else {
            return Container(
              child: Center(
                child: Text(
                  "Error"
                ),
              ),
            );
          }
        }
      )
    );
  }

  Widget _loginPage(AccountViewModel data, BuildContext context){
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/img_login.png", width: 200,),
          SizedBox(height: 20,),
          Text(
            "Oppsss...",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          SizedBox(height: 5,),
          Text(
            "Anda belum login\nsilahkan login terlebih dahulu",
            style: TextStyle(
                fontSize: 14
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30,),
          ButtonTheme(
            child: RaisedGradientButton(
              width: 200,
              gradient: LinearGradient(
                colors: <Color>[
                  colorPrimary,
                  colorPrimary
                ],
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginView(),
                  ),
                ).then((value) {
                  if(isLogin == true){
                    data.getUser(context);
                  }
                });
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _profilePage(AccountViewModel data, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: AssetImage("assets/images/default_avatar.png"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Widi Ramadhan",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "Edit Profil >",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Color(0xfff5f6f8),
              child: Text(
                "MANAJEMEN KONTRAK",
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _profileMenu(
                      title: "Daftar Kontrak",
                      icon: FontAwesomeIcons.fileContract
                  ),
                  _separator(),
                  _profileMenu(
                      title: "Riwayat Pembayaran",
                      icon: FontAwesomeIcons.history
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Color(0xfff5f6f8),
              child: Text(
                "PENGATURAN AKUN",
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _profileMenu(
                      title: "Ubah Profil",
                      icon: FontAwesomeIcons.idCard
                  ),
                  _separator(),
                  _profileMenu(
                      title: "Ubah Kata Sandi",
                      icon: FontAwesomeIcons.lock
                  ),
                  _separator(),
                  _profileMenu(
                      title: "Daftar Dokumen",
                      icon: FontAwesomeIcons.fileInvoice
                  ),
                  _separator(),
                  _profileMenu(
                      title: "Bima Poin",
                      icon: FontAwesomeIcons.coins
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              color: Color(0xfff5f6f8),
              child: Center(
                child: GestureDetector(
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


                          setState(() {
                            isLogin = false;
                          });
                          checkSessionLogin();
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
                          });
                        });
                  },
                  child: Text(
                    "Keluar",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _separator(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      height: 1,
      color: Colors.grey[300],
    );
  }

  Widget _profileMenu({
    @required String? title,
    @required String? value,
    VoidCallback? onTap,
    IconData? icon,
  }){
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              icon,
              color: colorPrimary,
              size: 20,
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 1,
            child: Text(
              "$title",
              style: TextStyle(
                fontSize: 14
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ),
        ],
      )
    );
  }
}
