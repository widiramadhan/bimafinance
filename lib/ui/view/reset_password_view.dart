import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/viewmodel/auth_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/widget/dialog_success.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class ResetPasswordView extends StatefulWidget {
  String? email;

  ResetPasswordView({Key? key, required this.email});

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

bool btnEnabled = false;

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _txtPasswordController = TextEditingController();
  final _txtConfirmationPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (data) {},
        builder: (context, data, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: colorPrimary,
                elevation: 0,
                brightness: Brightness.dark,
              ),
              body: ModalProgress(
              inAsyncCall: false,//data.state == ViewState.Busy ?? ViewState.Idle,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colorPrimary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text("Reset Password", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),),
                                ),
                                SizedBox(height: 5,),
                                Center(
                                  child: Text("masukan password baru untuk akun anda", style: TextStyle(fontSize: 14, color: Colors.grey),),
                                ),
                                SizedBox(height: 50,),
                                TextFormField(
                                  controller: _txtPasswordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: data.hidePass,
                                  decoration: InputDecoration(
                                    hintText: 'Kata Sandi Baru',
                                    labelText: 'Kata Sandi Baru',
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        data.hidePass
                                            ? FontAwesomeIcons.eyeSlash
                                            : FontAwesomeIcons.eye,
                                        color: Colors.black,
                                        size: 12,
                                      ),
                                      onPressed: () => data.changeHidePass(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _txtConfirmationPasswordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: data.hidePass2,
                                  decoration: InputDecoration(
                                    hintText: 'Konfirmasi Kata Sandi',
                                    labelText: 'Konfirmasi Kata Sandi',
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        data.hidePass2
                                            ? FontAwesomeIcons.eyeSlash
                                            : FontAwesomeIcons.eye,
                                        color: Colors.black,
                                        size: 12,
                                      ),
                                      onPressed: () => data.changeHidePass2(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                ButtonTheme(
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: RaisedGradientButton(
                                    gradient: LinearGradient(
                                     colors: <Color>[colorPrimary, colorPrimary],
                                   ),
                                    onPressed: () async {
                                      var reset = await data.resetPassword(widget.email!, _txtPasswordController.text, _txtConfirmationPasswordController.text, context);
                                      if(reset){
                                        SuccessDialog(
                                          context: context,
                                          title: "Sukses",
                                          content: "Password anda berhasil diubah",
                                          imageHeight: 100,
                                          imageWidth: 100,
                                          dialogHeight: 260,
                                          path: ''
                                        );
                                        Future.delayed(new Duration(seconds: 1), () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        });
                                      }
                                    },
                                    child: Text(
                                      "Update",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.asset("assets/images/logo_circle.png"),
                            ),
                          ),
                        ),
                      )
                    ],
                   )
                )
                ),
              ),
            ));
  }
}

