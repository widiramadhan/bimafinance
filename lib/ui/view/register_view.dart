import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/otp_type.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/auth_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/login_view.dart';
import 'package:bima_finance/ui/view/otp_view.dart';
import 'package:bima_finance/ui/widget/dialog_success.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _txtNameController = TextEditingController();
  final TextEditingController _txtEmailController = TextEditingController();
  final TextEditingController _txtPhoneNumberController = TextEditingController();
  final TextEditingController _txtPasswordController = TextEditingController();
  final TextEditingController _txtConfirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (data)  {
        },
        builder: (context, data, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: colorPrimary,
                elevation: 0,
                brightness: Brightness.dark,
              ),
              body: ModalProgress(
              inAsyncCall: data.state == ViewState.Idle,//data.state == ViewState.Busy ?? ViewState.Idle,
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
                                  child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),),
                                ),
                                SizedBox(height: 5,),
                                Center(
                                  child: Text("daftarkan diri anda di Bima Finance", style: TextStyle(fontSize: 14, color: Colors.grey),),
                                ),
                                SizedBox(height: 50,),
                                TextFormField(
                                  controller: _txtNameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Nama Lengkap',
                                    labelText: 'Nama Lengkap',
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _txtEmailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    labelText: 'Email',
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _txtPhoneNumberController,
                                  maxLength: 15,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'Nomor Telepon',
                                    labelText: 'Nomor Telepon',
                                    counterText: "",
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _txtPasswordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: data.hidePass,
                                  decoration: InputDecoration(
                                    hintText: 'Kata Sandi',
                                    labelText: 'Kata Sandi',
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
                                  controller: _txtConfirmPasswordController,
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
                                    var register = await data.register(
                                      _txtNameController.text,
                                      _txtEmailController.text, 
                                      _txtPhoneNumberController.text, 
                                      _txtPasswordController.text, 
                                      _txtConfirmPasswordController.text, 
                                      context);
                                      if(register) {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           OtpView(email: _txtEmailController.text, type: OtpType.Register,)),
                                        // );
                                        SuccessDialog(
                                          context: context,
                                          title: "Sukses",
                                          content: "Selamat akun anda berhasil dibuat",
                                          imageHeight: 100,
                                          imageWidth: 100,
                                          dialogHeight: 280,
                                          path: ''
                                        );
                                        Future.delayed(
                                            new Duration(seconds: 12), () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginView()),
                                          );
                                        });
                                      }
                                    },
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sudah memiliki akun ? ",
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginView()),
                                        );
                                      },
                                      child: Text(
                                        "Masuk disini",
                                        style: TextStyle(
                                            color: colorPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    )
                                  ],
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
                ),
              ),
            ))
    );
  }
}