import 'dart:async';
import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/view/index_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState(){
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async{
    animationController = new AnimationController(
        vsync : this, duration: new Duration(seconds: 2));
    animation =
    new CurvedAnimation(parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    var duration = const Duration(seconds: 3);
    return Timer(duration, () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // if(prefs.getBool('is_login') == true){
      //   Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (context) => HomeView(),
      //       )
      //   );
      // }else {
      //   Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (context) => LoginView(),
      //       )
      //   );
      // }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => IndexView(),
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png", width: animation!.value * 200, height: animation!.value * 200,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
