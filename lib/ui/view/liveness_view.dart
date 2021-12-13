import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class LivenessView extends StatefulWidget {
  String? nik;
  String? name;
  String? dob;
  String? gender;
  String? address;
  String? province;
  String? city;
  String? subDistrict;
  String? postalCode;
  File? ktpPhoto;

  LivenessView({
    Key? key,
    required this.nik,
    required this.name,
    required this.dob,
    required this.gender,
    required this.address,
    required this.province,
    required this.city,
    required this.subDistrict,
    required this.postalCode,
    required this.ktpPhoto,
  });

  @override
  _LivenessViewState createState() => _LivenessViewState();
}

class _LivenessViewState extends State<LivenessView> {

  File? _imageFile;
  dynamic _pickImageError;
  String? _retrieveDataError;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  _onImageButtonPressed(ImageSource source) async {
    try {
      final pickedFile = await picker.getImage(source: source);
      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e);
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
            toolbarColor: colorPrimary,
            toolbarWidgetColor: Colors.white,
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
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Verifikasi Wajah", style: TextStyle(color: colorPrimary),),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 2,
            brightness: Brightness.light,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: colorPrimary,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(_imageFile == null) ...[
                    Text(
                      "Ambil Foto Wajah",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Pastikan wajah kamu terlihat di dalam area foto",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30,),
                    Image.asset("assets/images/sampleLivenessKTP.png", width: 250,),
                    SizedBox(height: 30,),
                    Text(
                      "Panduan Foto Wajah",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Ambil foto dengan pencahayaan yang baik\nJangan menggunakan kacamata, masker, atau aksesoris lainnya",
                      textAlign: TextAlign.center,
                    ),
                  ] else ...[
                    Text(
                      "Hasil Foto Wajah",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Pastikan wajah kamu terlihat di dalam area foto",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30,),
                    Image.file(_imageFile!, width: 250,),
                    SizedBox(height: 30,),
                    Text(
                      "Panduan Foto Wajah",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Ambil foto dengan pencahayaan yang baik\nJangan menggunakan kacamata, masker, atau aksesoris lainnya",
                      textAlign: TextAlign.center,
                    ),
                  ]
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 60,
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              child: RaisedGradientButton(
                gradient: LinearGradient(
                  colors: <Color>[
                    colorPrimary,
                    colorPrimary
                  ],
                ),
                onPressed: () async {
                  if(_imageFile == null) {
                    await _onImageButtonPressed(ImageSource.camera);
                  } else {
                    print("test");
                  }
                },
                child: Text(
                  _imageFile == null ? "AMBIL FOTO" : "SUBMIT DATA",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ),
        )
    );
  }
}
