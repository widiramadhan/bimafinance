import 'dart:convert';

import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/repository/auth_repository.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:bima_finance/locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AuthViewModel extends BaseViewModel {
  AuthRepository authRepository = locator<AuthRepository>();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  bool isLogin = false;
  bool hidePass = true;
  bool hidePass2 = true;
  bool hidePass3 = true;

  void changeHidePass() {
    hidePass = !hidePass;
    notifyListeners();
  }

  void changeHidePass2() {
    hidePass2 = !hidePass2;
    notifyListeners();
  }

  void changeHidePass3() {
    hidePass3 = !hidePass3;
    notifyListeners();
  }

  Future<String?> checkSessionLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    isLogin = prefs.getBool('is_login') ?? false;
    notifyListeners();
  }

  Future<bool> checkLogin(String strEmail, String strPassword, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (strEmail == "" || strPassword == "") {
      Toast.show("Please complete this form", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }

    setState(ViewState.Busy);
    var success = await authRepository.checkLogin(strEmail, strPassword, context);
    setState(ViewState.Idle);
    if (success) {
      return true;
    } else {
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }
  }

  // Future<bool> loginWithFscebook(BuildContext context) async{
  //   final FacebookLogin facebookSignIn = new FacebookLogin();
  //   final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
  //
  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final FacebookAccessToken accessToken = result.accessToken;
  //       print('''
  //        Logged in!
  //
  //        Token: ${accessToken.token}
  //        User id: ${accessToken.userId}
  //        Expires: ${accessToken.expires}
  //        Permissions: ${accessToken.permissions}
  //        Declined permissions: ${accessToken.declinedPermissions}
  //        ''');
  //
  //       Dio dio = new Dio();
  //       var graphResponse = await dio.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${result.accessToken.token}');
  //
  //       /*var photoProfileResponse = await http.get("https://graph.facebook.com/v3.1/$facebookId/picture?type=large");
  //       print("photo profile : "+photoProfileResponse.toString());*/
  //
  //       var profile = json.decode(graphResponse.data);
  //       String facebookId = profile['id'].toString();
  //       String name = profile['name'];
  //       String email = profile['email'];
  //       String phoneNumber = "";
  //       String profile_picture = profile['picture']['url'];
  //
  //       setState(ViewState.Busy);
  //       final SharedPreferences prefs = await SharedPreferences.getInstance();
  //       var success = await authRepository.loginWithSSO(name, email, phoneNumber, profile_picture, context);
  //
  //       if (!success) {
  //         Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //         setState(ViewState.Idle);
  //         return false;
  //       }
  //
  //       setState(ViewState.Idle);
  //       return success;
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       Toast.show('Login cancelled by the user.', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //       setState(ViewState.Idle);
  //       return false;
  //       break;
  //     case FacebookLoginStatus.error:
  //       print('Something went wrong with the login process.\n'
  //           'Here\'s the error Facebook gave us: ${result.errorMessage}');
  //       Toast.show('Something went wrong with the login process.\n'
  //           'Here\'s the error Facebook gave us: ${result.errorMessage}', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //       setState(ViewState.Idle);
  //       return false;
  //       break;
  //   }
  // }
  //
  // Future<bool> loginWithGoogle(BuildContext context) async{
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //
  //   final UserCredential authResult = await _auth.signInWithCredential(credential);
  //   final User user = authResult.user;
  //
  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);
  //
  //   final User currentUser = await _auth.currentUser;
  //   assert(user.uid == currentUser.uid);
  //
  //   if(user.uid != null){
  //     String name = user.displayName;
  //     String email = user.email;
  //     String phoneNumber = "";
  //     String profile_picture = user.photoURL;
  //
  //     setState(ViewState.Busy);
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var success = await authRepository.loginWithSSO(name, email, phoneNumber, profile_picture, context);
  //
  //     if (!success) {
  //       Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //       setState(ViewState.Idle);
  //       return false;
  //     }
  //
  //     setState(ViewState.Idle);
  //     return success;
  //   }else{
  //     Toast.show('Something went wrong with the login process', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //     setState(ViewState.Idle);
  //     return false;
  //   }
  // }

  Future<bool> loginWithApple(BuildContext context) async{
    setState(ViewState.Busy);
    Toast.show('Under maintenance', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    setState(ViewState.Idle);
    return false;
  }

  Future<bool> forgotPassword(String strEmail, BuildContext context) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    if(strEmail == ''){
      Toast.show('Please complete the form', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }

    var success = await authRepository.forgotPassword(strEmail, context);
    setState(ViewState.Idle);
    if(success){
      return true;
    }else{
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
  }

  Future<bool> resendOTP(String strEmail, BuildContext context) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    var success = await authRepository.resendOTP(strEmail, context);
    setState(ViewState.Idle);
    if(success){
      return true;
    }else{
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
  }

  Future<bool> verifyOTP(String strEmail, String strOtp, BuildContext context) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    var success = await authRepository.verifyOTP(strEmail, strOtp, context);
    setState(ViewState.Idle);
    if(success){
      return true;
    }else{
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
  }

  Future<bool> resetPassword(String strEmail, String strPassword, String strConfirmPassword, BuildContext context) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    if(strPassword == '' || strConfirmPassword == ''){
      Toast.show('Please complete the form', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }

    if(strPassword != strConfirmPassword){
      Toast.show('Konfirmasi kata sandi harus sama dengan kata sandi yang anda inputkan', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }
    var success = await authRepository.resetPassword(strEmail, strPassword, context);
    setState(ViewState.Idle);
    if(success){
      return true;
    }else{
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
  }

  Future<bool> changePassword(String strOldPassword, String strNewPassword, String strConfirmPassword, BuildContext context) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    if(strOldPassword == '' || strNewPassword == '' || strConfirmPassword == ''){
      Toast.show('Please complete the form', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }

    if(strNewPassword != strConfirmPassword){
      Toast.show('Konfirmasi kata sandi harus sama dengan kata sandi yang anda inputkan', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }
    var success = await authRepository.changePassword(strOldPassword, strNewPassword, context);
    setState(ViewState.Idle);
    if(success){
      return true;
    }else{
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
  }


  Future<bool> register(String strFullName, String strEmail, String strPhoneNumber, String strPassword, String strConfirmPassword, BuildContext context) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    if(strFullName == '' || strEmail == '' || strPhoneNumber == '' || strPassword == '' || strConfirmPassword == ''){
      Toast.show('Please complete the form', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }

    //validasi email
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    if(!regExp.hasMatch(strEmail)){
      Toast.show('Email tidak valid', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }

    //validasi nomor telepon
    if(strPhoneNumber.length < 10){
      Toast.show('Nomor telepon minimal 10 digit', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }else if(strPhoneNumber.length > 15){
      Toast.show('Nomor telepon maksimal 15 digit', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }else if(strPhoneNumber.substring(0,2) != "08"){
      Toast.show('Nomor telepon harus berawalan 08xxxxxx', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }

    if(strPassword != strConfirmPassword){
      Toast.show('Konfirmasi kata sandi harus sama dengan kata sandi yang anda inputkan', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(ViewState.Idle);
      return false;
    }
    var success = await authRepository.register(strFullName, strEmail, strPhoneNumber, strPassword, context);
    setState(ViewState.Idle);
    if(success){
      return true;
    }else{
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
  }

  Future<bool> activatedAccount(String strEmail, String strOtp, BuildContext context) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    var success = await authRepository.activeatedAccount(strEmail, strOtp, context);
    setState(ViewState.Idle);
    if(success){
      return true;
    }else{
      Toast.show(prefs.getString('message'), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
  }
}
