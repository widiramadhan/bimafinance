import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/view/login_view.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
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
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  );
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
}