import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/viewmodel/home_viewmodel.dart';
import 'package:bima_finance/ui/view/contract_view.dart';
import 'package:bima_finance/ui/view/credit_simulation_view.dart';
import 'package:bima_finance/ui/view/login_view.dart';
import 'package:bima_finance/ui/view/ocr_guide_view.dart';
import 'package:bima_finance/ui/view/register_view.dart';
import 'package:bima_finance/ui/widget/dialog_question.dart';
import 'package:bima_finance/ui/widget/dialog_success.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DrawerWidget extends StatelessWidget {
  bool? isLogin;
  String? name;
  String? email;

  DrawerWidget({
    Key? key,
    required this.isLogin,
    required this.name,
    required this.email
  });
  @override
  Widget build(BuildContext context) {
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
                          Navigator.pop(context, isLogin = false);
                          Navigator.pop(context, isLogin = false);
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
                  ).then((value) {
                    HomeViewModel home = HomeViewModel();
                    home.init(context);
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
                  ).then((value) {
                    HomeViewModel home = HomeViewModel();
                    home.init(context);
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