import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/view/about_view.dart';
import 'package:bima_finance/ui/view/account_view.dart';
import 'package:bima_finance/ui/view/contract_view.dart';
import 'package:bima_finance/ui/view/help_view.dart';
import 'package:bima_finance/ui/view/home_view.dart';
import 'package:bima_finance/ui/widget/dialog_question.dart';
import 'package:bima_finance/ui/widget/fab_bottom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class IndexView extends StatefulWidget {
  @override
  _IndexViewState createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  int _selectedTabIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  final _listPage = <Widget>[
    HomeView(),
    ContractView(),
    HelpView(),
    AccountView(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {

          return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: Text("Keluar"),
              content: Text("Apakah anda yakin ingin keluar dari aplikasi?"),
              actions: [
                TextButton(
                  child: Text("Batal"),
                  onPressed:  () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text("Keluar"),
                  onPressed:  () {
                    //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                ),
              ],
            ),
          )) ?? false;
        },
        child: Center(
          child: _listPage[_selectedTabIndex],
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        selectedColor: colorPrimary,
        centerItemText: "Bima Finance",
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: FontAwesomeIcons.home, text: 'Home'),
          FABBottomAppBarItem(iconData: FontAwesomeIcons.fileContract, text: 'Aplikasi'),
          FABBottomAppBarItem(iconData: FontAwesomeIcons.headset, text: 'Bantuan'),
          FABBottomAppBarItem(iconData: FontAwesomeIcons.userCircle, text: 'Akun'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        _listPage[0];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AboutView(),
          ),
        );
      },
      tooltip: 'Home',
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.white
          ),
          child: Image.asset(
            "assets/images/logo_circle.png",
            width: 200,
            height: 200,
          ),
        ),
      elevation: 2.0,
    );
  }
}
