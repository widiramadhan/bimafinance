import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/viewmodel/auth_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/reset_password_view.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _txtEmailController = TextEditingController();

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

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
                                      child: Text("Lupa Kata Sandi", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),),
                                    ),
                                    SizedBox(height: 5,),
                                    Center(
                                      child: Text("masukan email anda untuk reset password", style: TextStyle(fontSize: 14, color: Colors.grey),),
                                    ),
                                    SizedBox(height: 50,),
                                    TextFormField(
                                      controller: _txtEmailController,
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        labelText: 'Email',
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    ButtonTheme(
                                      disabledColor: Colors.grey,
                                      minWidth: MediaQuery.of(context).size.width,
                                      child: RaisedGradientButton(
                                        gradient: LinearGradient(
                                          colors: <Color>[colorPrimary, colorPrimary],
                                        ),
                                        onPressed: () async {
                                          hideKeyboard(context);
                                          var forgot = await data.forgotPassword(_txtEmailController.text, context);
                                          if(forgot){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ResetPasswordView(email: _txtEmailController.text)),//OtpView(email: _txtEmailController.text, type: OtpType.ForgotPassword,)),
                                            );
                                          }
                                        },
                                        child: Text(
                                          "Reset",
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
                  ),
                ),
              )
            ));
  }
}