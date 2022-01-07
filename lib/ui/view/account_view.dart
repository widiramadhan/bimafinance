import 'dart:io';

import 'package:badges/badges.dart';
import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/viewmodel/account_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/view/contract_view.dart';
import 'package:bima_finance/ui/view/login_view.dart';
import 'package:bima_finance/ui/view/photo_viewer_view.dart';
import 'package:bima_finance/ui/widget/dialog_question.dart';
import 'package:bima_finance/ui/widget/dialog_success.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:bima_finance/ui/widget/menu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_text/skeleton_text.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {

  @override
  void initState() {
    super.initState();
  }

  bool isLogin = false;
  File? _imageFile;
  dynamic _pickImageError;
  String? _retrieveDataError;
  final picker = ImagePicker();

  Future<bool> checkSessionLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('is_login') ?? false;
    return isLogin;
  }

   _onImageButtonPressed(ImageSource? source) async {
    try {
      final pickedFile = await picker.getImage(source: source!);
      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      _pickImageError = e;
    }
    if(_imageFile != null){
      await _cropImage();
    }
    setState(() {});
  }

  Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: _imageFile!.path,
        aspectRatioPresets: Platform.isAndroid ? [CropAspectRatioPreset.square]
            : [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.white,
            toolbarWidgetColor: colorPrimary,
            initAspectRatio: CropAspectRatioPreset.square,
            hideBottomControls: true,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Image',
          cancelButtonTitle: 'Batal',
          doneButtonTitle: 'Gunakan',
          resetButtonHidden: true,
          rotateButtonsHidden: true,
          aspectRatioPickerButtonHidden: true,
          aspectRatioLockEnabled: true,
        )
    );

    if (croppedFile != null) {
      _imageFile = croppedFile;
      setState((){});
    }else{
      _imageFile = null;
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akun", style: TextStyle(color: colorPrimary),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        brightness: Brightness.light,
      ),
      body: FutureBuilder(
        future: checkSessionLogin(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return BaseView<AccountViewModel>(
                onModelReady: (data) async {
                  if(isLogin == true){
                    data.getUser(context);
                  }
                },
              builder: (context, data, child) {
                if(isLogin == false) {
                  return _loginPage(data, context);
                } else {
                  if(data.user == null) {
                    return Center(child: CircularProgressIndicator(color: colorPrimary,),);
                  } else {
                    return _profilePage(data, context);
                  }
                }
              }
            );
          } else {
            return Container(
              child: Center(
                child: Text(
                  "Error"
                ),
              ),
            );
          }
        }
      )
    );
  }

  Widget _loginPage(AccountViewModel data, BuildContext context){
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/img_login.png", width: 300,),
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
              fontSize: 14,
              color: Colors.grey
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginView(),
                  ),
                ).then((value) async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  if(prefs.getBool('is_login') == true){
                    data.getUser(context);
                    setState(() {
                      isLogin = true;
                    });
                  }
                });
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

  Widget _profilePage(AccountViewModel data, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc){
                            return Container(
                              child: new Wrap(
                                children: <Widget>[
                                  new ListTile(
                                      leading: new Icon(Icons.account_circle, color: colorPrimary,),
                                      title: new Text('Lihat foto profil', style: TextStyle(fontSize: 12),),
                                      enabled: data.user!.url_images != null ? true : false,
                                      onTap: () async {
                                        if (data.user!.url_images != null) {
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PhotoViewerView(path: data.user!.url_images),
                                              )
                                          );
                                        }
                                      }
                                  ),
                                  new ListTile(
                                    leading: new Icon(Icons.camera_alt, color: colorPrimary),
                                    title: new Text('Ganti foto profil dari kamera', style: TextStyle(fontSize: 12),),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await _onImageButtonPressed(ImageSource.camera);
                                      print(_imageFile);
                                      if(_imageFile != null){
                                        var updatePhoto = await data.updateUserImages(_imageFile!, context);
                                        if (updatePhoto) {
                                          data.getUser(context);
                                          _imageFile = null;
                                        }
                                      }
                                    },
                                  ),
                                  new ListTile(
                                    leading: new Icon(Icons.photo, color: colorPrimary),
                                    title: new Text('Ganti foto profil dari galeri', style: TextStyle(fontSize: 12),),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await _onImageButtonPressed(ImageSource.gallery);
                                      print(_imageFile);
                                      if(_imageFile != null){
                                        var updatePhoto = await data.updateUserImages(_imageFile!, context);
                                        if (updatePhoto) {
                                          data.getUser(context);
                                          _imageFile = null;
                                        }
                                      }
                                    },
                                  ),
                                  new ListTile(
                                    leading: new Icon(Icons.delete, color: colorPrimary),
                                    title: new Text('Hapus foto profil', style: TextStyle(fontSize: 12),),
                                    enabled: data.user!.url_images != null ? true : false,
                                    onTap: () async {
                                      Navigator.pop(context);
                                      var deletePhoto = await data.deleteProfilePicture(context);
                                      if (deletePhoto) {
                                        data.getUser(context);
                                        _imageFile = null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                      );
                    },
                    child: Badge(
                      badgeColor: colorPrimary,
                      shape: BadgeShape.circle,
                      borderRadius: BorderRadius.circular(20),
                      padding: EdgeInsets.all(10),
                      toAnimate: false,
                      position: BadgePosition.bottomEnd(end: -10, bottom: 0),
                      badgeContent: Icon(FontAwesomeIcons.camera, color: Colors.white, size: 12,),
                      child: ClipOval(
                        child: data.user!.url_images == null || data.user!.url_images == "" ? Image.asset("assets/images/default_avatar.png", fit: BoxFit.cover, width: 80, height: 80,) :
                        CachedNetworkImage(
                          imageUrl: data.user!.url_images!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => new SkeletonAnimation(
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.all(Radius.circular(50))
                                ),
                              )
                          ),
                          errorWidget: (context, url, error) => new Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                            child: Center(
                              child: Icon(
                                  Icons.error
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Widi Ramadhan",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Edit Profil",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Color(0xfff5f6f8),
              child: Text(
                "MANAJEMEN KONTRAK",
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  MenuWidget(
                    title: "Daftar Kontrak",
                    icon: FontAwesomeIcons.fileContract,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContractView(isBack: true),
                        ),
                      );
                    },
                  ),
                  _separator(),
                  MenuWidget(
                    title: "Riwayat Pembayaran",
                    icon: FontAwesomeIcons.history,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Color(0xfff5f6f8),
              child: Text(
                "PENGATURAN AKUN",
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  MenuWidget(
                    title: "Ubah Profil",
                    icon: FontAwesomeIcons.idCard,
                    onTap: () {},
                  ),
                  _separator(),
                  MenuWidget(
                    title: "Ubah Kata Sandi",
                    icon: FontAwesomeIcons.lock,
                    onTap: () {},
                  ),
                  // _separator(),
                  // MenuWidget(
                  //   title: "Daftar Dokumen",
                  //   icon: FontAwesomeIcons.fileInvoice,
                  //   onTap: () {},
                  // ),
                  // _separator(),
                  // MenuWidget(
                  //   title: "Bima Poin",
                  //   icon: FontAwesomeIcons.coins,
                  //   onTap: () {},
                  // ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              color: Color(0xfff5f6f8),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    DialogQuestion(
                        context: context,
                        path: "assets/images/img_failed.png",
                        content: "Apakah anda yakin ingin keluar \ndari akun ini ?",
                        title: "Logout",
                        appName: "",
                        imageHeight: 100,
                        imageWidth: 100,
                        dialogHeight: 260,
                        buttonConfig: ButtonConfig(
                          dialogDone: "Yakin",
                          dialogCancel: "Batal",
                          buttonDoneColor: colorPrimary,
                        ),
                        submit: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove('user_id');
                          prefs.remove('email');
                          prefs.remove('token');
                          prefs.remove('is_login');


                          setState(() {
                            isLogin = false;
                          });
                          checkSessionLogin();
                          SuccessDialog(
                            context: context,
                            title: "Sukses",
                            content: "Berhasil keluar dari akun",
                            imageHeight: 100,
                            imageWidth: 100,
                            dialogHeight: 260,
                          );
                          new Future.delayed(new Duration(seconds: 1), () {
                            Navigator.pop(context);
                          });
                        });
                  },
                  child: Text(
                    "Keluar",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _separator(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      height: 1,
      color: Colors.grey[300],
    );
  }
}
