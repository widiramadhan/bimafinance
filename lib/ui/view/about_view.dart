import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/web_url.dart';
import 'package:bima_finance/ui/view/webview_view.dart';
import 'package:bima_finance/ui/widget/menu.dart';
import 'package:bima_finance/ui/widget/separator.dart';
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
        elevation: 0,
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
                    MenuWidget(
                      title: "Sejarah",
                      icon: FontAwesomeIcons.building,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebviewView(
                              title: "Sejarah",
                              url: WebURL().sejarah,
                            ),
                          ),
                        );
                      }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Visi & Misi",
                        icon: FontAwesomeIcons.handshake,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Visi & Misi",
                                url: WebURL().visiMisi,
                              ),
                            ),
                          );
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Kultur",
                        icon: FontAwesomeIcons.laptopHouse,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Kultur",
                                url: WebURL().cultur,
                              ),
                            ),
                          );
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Manajemen",
                        icon: FontAwesomeIcons.networkWired,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Manajemen",
                                url: WebURL().manajemen,
                              ),
                            ),
                          );
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Penghargaan",
                        icon: FontAwesomeIcons.trophy,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Penghargaan",
                                url: WebURL().penghargaan,
                              ),
                            ),
                          );
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Laporan Tahunan",
                        icon: FontAwesomeIcons.fileArchive,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Laporan Tahunan",
                                url: WebURL().laporanTahunan,
                              ),
                            ),
                          );
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Obligasi",
                        icon: FontAwesomeIcons.fileSignature,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Obligasi",
                                url: WebURL().obligasi,
                              ),
                            ),
                          );
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Publikasi",
                        icon: FontAwesomeIcons.fileCode,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Publikasi",
                                url: WebURL().publikasi,
                              ),
                            ),
                          );
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Laporan Keberlanjutan",
                        icon: FontAwesomeIcons.fileImport,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Laporan Keberlanjutan",
                                url: WebURL().laporanKeberlanjutan,
                              ),
                            ),
                          );
                        }
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
                    MenuWidget(
                        title: "Bima Finance Mobile",
                        icon: FontAwesomeIcons.mobileAlt,
                        onTap: () {

                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Kebijakan Privasi",
                        icon: FontAwesomeIcons.lock,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Kebijakan Privasi",
                                url: "https://loremipsum.io/privacy-policy/",
                              ),
                            ),
                          );
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Syarat & Ketentuan",
                        icon: FontAwesomeIcons.fileInvoice,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Syarat & Ketentuan",
                                url: "https://generator.lorem-ipsum.info/terms-and-conditions",
                              ),
                            ),
                          );
                        }
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
}
