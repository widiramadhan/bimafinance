import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/field_style.dart';
import 'package:bima_finance/core/constant/otp_type.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/auth_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/login_view.dart';
import 'package:bima_finance/ui/view/reset_password_view.dart';
import 'package:bima_finance/ui/widget/dialog_success.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:bima_finance/ui/widget/otp_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class OtpView extends StatefulWidget {
  String? email;
  OtpType? type;

  OtpView({Key? key, required this.email, required this.type});

  @override
  _OtpViewState createState() => _OtpViewState();
}

bool btnEnabled = false;

class _OtpViewState extends State<OtpView> with TickerProviderStateMixin {
  String? otp;

  int? _counter = 0;
  AnimationController? _controller;
  int? levelClock = 300;

  void _incrementCounter() {
    setState(() {
      //_counter++;
      _counter = _counter! + 1;
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
            levelClock!)
    );

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (data) {},
        builder: (context, data, child) => Scaffold(
              appBar: AppBar(
                elevation: 2,
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
                                  Container(
                                    width: double.infinity,
                                    child: Text("OTP", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24), textAlign: TextAlign.center,),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: double.infinity,
                                    child: Text("kode OTP dikirim ke email ${widget.email}", style: TextStyle(fontSize: 14, color: Colors.grey), textAlign: TextAlign.center,),
                                  ),
                                  SizedBox(height: 50,),
                                  Center(
                                    child: OTPTextField(
                                      length: 6,
                                      width: MediaQuery.of(context).size.width,
                                      fieldWidth: 50,
                                      style: TextStyle(fontSize: 30),
                                      textFieldAlignment: MainAxisAlignment.spaceAround,
                                      fieldStyle: FieldStyle.box,
                                      onCompleted: (pin) {
                                        setState(() {
                                          otp = pin;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                    child: Countdown(
                                      animation: StepTween(
                                        begin: levelClock, // THIS IS A USER ENTERED NUMBER
                                        end: 0,
                                      ).animate(_controller!),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if(btnEnabled == true){
                                        var requestAgain = await data.resendOTP(widget.email!, context);
                                        if(requestAgain == true){
                                          _controller!.reset();
                                          setState(() {
                                            btnEnabled = false;
                                            _controller = AnimationController(
                                                vsync: this,
                                                duration: Duration(
                                                    seconds: levelClock!
                                                ) // gameData.levelClock is a user entered number elsewhere in the applciation
                                            );
                                            _controller!.forward();
                                          });
                                        }
                                      }else {
                                        Toast.show('Belum bisa request OTP baru, tunggu beberapa saat', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                            FontAwesomeIcons.redo,
                                            size: 14,
                                            color: colorPrimary
                                        ),
                                        SizedBox(width: 5,),
                                        Text("Kirim ulang", style: TextStyle(color: Colors.grey, fontSize: 14),)
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  ButtonTheme(
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: RaisedGradientButton(
                                      gradient: LinearGradient(
                                       colors: <Color>[colorPrimary, colorPrimary],
                                     ),
                                      onPressed: () async {
                                        var verify = await data.verifyOTP(widget.email!, otp!, context);
                                        if(verify){
                                          if(widget.type == OtpType.ForgotPassword) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ResetPasswordView(
                                                          email: widget.email)),
                                            );
                                          }else if(widget.type == OtpType.Register){
                                            var activate = await data.activatedAccount(widget.email!, otp!, context);
                                            if(activate) {
                                              SuccessDialog(
                                                context: context,
                                                title: "Sukses",
                                                content: "Selamat akun anda berhasil dibuat",
                                                imageHeight: 100,
                                                imageWidth: 100,
                                                dialogHeight: 260,
                                              );
                                              Future.delayed(
                                                  new Duration(seconds: 1), () {
                                                Navigator.pop(context);
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
                                          }else if(widget.type == OtpType.changePassword){

                                          }
                                        }
                                      },
                                      child: Text(
                                        "Konfirmasi",
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
                                child: Image.asset("assets/images/logo_dark.png"),
                              ),
                            ),
                          ),
                        )
                      ],
                     )
                  ),
                )
              ),
            ));
  }
}


class Countdown extends AnimatedWidget {
  Countdown({Key? key, this.animation}) : super(key: key, listenable: animation!);
  Animation<int>? animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation!.value!);

    String timerText = '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    if(animation!.value == 0){
      btnEnabled = true;
    }else{
      btnEnabled = false;
    }

    return Text(
      "$timerText",
      style: TextStyle(
          fontSize: 24,
          color: Colors.black45,
          fontWeight: FontWeight.bold
      ),
    );
  }
}
