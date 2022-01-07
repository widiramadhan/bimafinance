import 'dart:async';
import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/auth_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/widget/dialog_success.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ChangePasswordView extends StatefulWidget {

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (data) {},
        builder: (context, data, child) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: colorPrimary,
          ),
          body: ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
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
                                    child: Text("Ubah Kata Sandi", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),),
                                  ),
                                  SizedBox(height: 5,),
                                  Center(
                                    child: Text("masukan kata sandi untuk akun anda", style: TextStyle(fontSize: 14, color: Colors.grey),),
                                  ),
                                  SizedBox(height: 50,),
                                  TextFormField(
                                    controller: _oldPasswordController,
                                    keyboardType: TextInputType.text,
                                    obscureText: data.hidePass,
                                    decoration: InputDecoration(
                                      hintText: 'Kata Sandi Lama',
                                      labelText: 'Kata Sandi Lama',
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
                                    controller: _newPasswordController,
                                    keyboardType: TextInputType.text,
                                    obscureText: data.hidePass2,
                                    decoration: InputDecoration(
                                      hintText: 'Kata Sandi Baru',
                                      labelText: 'Kata Sandi Baru',
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
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    keyboardType: TextInputType.text,
                                    obscureText: data.hidePass3,
                                    decoration: InputDecoration(
                                      hintText: 'Konfirmasi Kata Sandi',
                                      labelText: 'Konfirmasi Kata Sandi',
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          data.hidePass3
                                              ? FontAwesomeIcons.eyeSlash
                                              : FontAwesomeIcons.eye,
                                          color: Colors.black,
                                          size: 12,
                                        ),
                                        onPressed: () => data.changeHidePass3(),
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
                                        var changePassword = await data.changePassword(_oldPasswordController.text, _newPasswordController.text, _confirmPasswordController.text, context);
                                        if(changePassword){
                                          SuccessDialog(
                                            context: context,
                                            title: "Sukses",
                                            content: "Password anda berhasil diubah",
                                            imageHeight: 100,
                                            imageWidth: 100,
                                            dialogHeight: 260,
                                          );
                                          Future.delayed(new Duration(seconds: 1), () {
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
