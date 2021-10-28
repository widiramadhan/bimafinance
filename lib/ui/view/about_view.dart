import 'package:bima_finance/core/constant/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6f8),
      appBar: AppBar(
        title: Text("Tentang Kami", style: TextStyle(color: colorPrimary),),
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
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                color: Color(0xfff5f6f8),
                child: Text(
                  "PT. BIMA MULTI FINANCE",
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
                        title: "Sejarah",
                        icon: FontAwesomeIcons.building
                    ),
                    _separator(),
                    _profileMenu(
                        title: "Visi & Misi",
                        icon: FontAwesomeIcons.handshake
                    ),
                    _separator(),
                    _profileMenu(
                        title: "Kultur",
                        icon: FontAwesomeIcons.laptopHouse
                    ),
                    _separator(),
                    _profileMenu(
                        title: "Manajemen",
                        icon: FontAwesomeIcons.networkWired
                    ),
                    _separator(),
                    _profileMenu(
                        title: "Penghargaan",
                        icon: FontAwesomeIcons.trophy
                    ),
                    _separator(),
                    _profileMenu(
                        title: "Laporan Tahunan",
                        icon: FontAwesomeIcons.fileArchive
                    ),
                    _separator(),
                    _profileMenu(
                        title: "Obligasi",
                        icon: FontAwesomeIcons.fileSignature
                    ),
                    _separator(),
                    _profileMenu(
                        title: "Publikasi",
                        icon: FontAwesomeIcons.fileCode
                    ),
                    _separator(),
                    _profileMenu(
                        title: "Laporan Keberlanjutan",
                        icon: FontAwesomeIcons.fileImport
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Color(0xfff5f6f8),
                child: Text(
                  "TENTANG APLIKASI",
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
                        title: "Bima Finance Mobile",
                        icon: FontAwesomeIcons.mobileAlt
                    ),
                    _separator(),
                    _profileMenu(
                        title: "Kebijakan Privasi",
                        icon: FontAwesomeIcons.lock
                    ),
                    _separator(),
                    _profileMenu(
                        title: "Syarat & Ketentuan",
                        icon: FontAwesomeIcons.fileInvoice
                    ),
                  ],
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
