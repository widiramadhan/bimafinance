import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/web_url.dart';
import 'package:bima_finance/ui/view/branch_view.dart';
import 'package:bima_finance/ui/view/pdf_view.dart';
import 'package:bima_finance/ui/view/webview_view.dart';
import 'package:bima_finance/ui/widget/menu.dart';
import 'package:bima_finance/ui/widget/separator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpView extends StatefulWidget {
  @override
  _HelpViewState createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {

  @override
  void initState() {
    super.initState();
  }

  void _launchWhatsapp(String phone, String message) async {
    final url = 'https://wa.me/$phone?text=${Uri.parse(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show("Could not launch whatsapp, please install whatsapp in store", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      //throw 'Could not launch $url';
    }
  }

  void _launchEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'bimapeduli@bimafinance.co.id',
    );
    String  url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show("Could not launch mail, please install mail in store", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<void> _launchPhone(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show(
          "Could not launch phone number", context, duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
      //throw 'Could not launch $url';
    }
  }

  Future<File> createFileOfPdfUrl({String urlP = ''}) async {
    final url = urlP;
    String filename = '${DateTime.now().microsecondsSinceEpoch}';
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;

    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6f8),
      appBar: AppBar(
        title: Text("Bantuan", style: TextStyle(color: colorPrimary),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
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
                  "KONTAK KAMI",
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
                        title: "Telepon",
                        icon: FontAwesomeIcons.phone,
                        onTap: () {
                          _launchPhone('tel:02163858555');
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Email",
                        icon: FontAwesomeIcons.envelope,
                        onTap: () {
                          _launchEmail();
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Lokasi",
                        icon: FontAwesomeIcons.mapMarkerAlt,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BranchView(),
                            ),
                          );
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "WhatsApp",
                        icon: FontAwesomeIcons.whatsapp,
                        onTap: () {
                          _launchWhatsapp('682311800180', "Halo, saya ingin bertanya mengenai Bima Finance");
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Berikan Pendapat Anda",
                        icon: FontAwesomeIcons.comment,
                        onTap: () {
                          Toast.show("Layanan ini belum tersedia", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
                  "LAYANAN PELANGGAN",
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
                        title: "Layanan Pengaduan Konsumen",
                        icon: FontAwesomeIcons.fileCode,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Layanan Pengaduan",
                                url: WebURL().layananPengaduan,
                              ),
                            ),
                          );
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Formulir Pengaduan Konsumen",
                        icon: FontAwesomeIcons.filePdf,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Formulir Pengaduan Konsumen",
                                url: "https://docs.google.com/viewer?url=http://www.bimafinance.co.id/wp-content/uploads/Formulir-Pengaduan-Konsumen.pdf",
                              ),
                            ),
                          );
                        }
                    ),
                    SeparatorWidget(),
                    MenuWidget(
                        title: "Pengkinian Data Debitur",
                        icon: FontAwesomeIcons.idCard,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewView(
                                title: "Pengkinian Data Debitur",
                                url: WebURL().pengkinianDataDebitur,
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
