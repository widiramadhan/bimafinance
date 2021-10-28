import 'package:bima_finance/core/constant/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      body: SingleChildScrollView(
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
            ],
          ),
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
