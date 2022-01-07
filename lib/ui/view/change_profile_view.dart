import 'dart:async';
import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/model/user_model.dart';
import 'package:bima_finance/core/viewmodel/account_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/widget/dialog_success.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ChangeProfileView extends StatefulWidget {
  final UserModel? user;

  ChangeProfileView({Key? key, required this.user});

  @override
  _ChangeProfileViewState createState() => _ChangeProfileViewState();
}

class _ChangeProfileViewState extends State<ChangeProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.user!.fullname!;
    _phoneNumberController.text = widget.user!.phone!;
    _emailController.text = widget.user!.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AccountViewModel>(
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
                                    child: Text("Ubah Profil", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),),
                                  ),
                                  SizedBox(height: 5,),
                                  Center(
                                    child: Text("ubah data anda disni", style: TextStyle(fontSize: 14, color: Colors.grey),),
                                  ),
                                  SizedBox(height: 50,),
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    readOnly: true,
                                    enabled: false,
                                    style: TextStyle(
                                      color: Colors.grey
                                    ),
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
                                    controller: _nameController,
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
                                    controller: _phoneNumberController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 15,
                                    decoration: InputDecoration(
                                      hintText: 'Nomor Telepon',
                                      labelText: 'Nomor Telepon',
                                      counterText: '',
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
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
                                        var update = await data.updateProfile(_nameController.text, _phoneNumberController.text, context);
                                        if(update){
                                          SuccessDialog(
                                            context: context,
                                            title: "Sukses",
                                            content: "Data anda berhasil diubah",
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
