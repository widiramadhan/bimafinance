import 'dart:io';

import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/view/work_information_view.dart';
import 'package:bima_finance/ui/widget/gradient_button.dart';
import 'package:bima_finance/ui/widget/step_wizard_widget.dart';
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
  String? phoneNumber;
  String? motherName;
  String? emergencyContact;
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
    required this.phoneNumber,
    required this.motherName,
    required this.emergencyContact,
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
    return Scaffold(
          appBar: AppBar(
            title: Text("Verifikasi Data", style: TextStyle(color: colorPrimary),),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: StepWizardWidget(
                        active: true,
                        title: "Konfirmasi Data",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: StepWizardWidget(
                        active: false,
                        title: "Informasi Pekerjaan",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: StepWizardWidget(
                        active: false,
                        title: "Pengajuan Kredit",
                      ),
                    )
                  ],
                ),
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
                    Image.asset("assets/images/sampleLivenessKTP.png", width: 200,),
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
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x80cacccf),
                  offset: Offset(0, -1),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
              color: Colors.white,
            ),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) =>
                          WorkInformationView(
                            nik: widget.nik!,
                            name: widget.name!,
                            dob: widget.dob!,
                            gender: widget.gender!,
                            address: widget.address!,
                            province: widget.province!,
                            city: widget.city!,
                            subDistrict: widget.subDistrict!,
                            postalCode: widget.postalCode!,
                            phoneNumber: widget.phoneNumber!,
                            motherName: widget.motherName!,
                            emergencyContact: widget.emergencyContact,
                            ktpPhoto: widget.ktpPhoto,
                            selfiePhoto: _imageFile,
                          ),
                    ));
                  }
                },
                child: Text(
                  _imageFile == null ? "AMBIL FOTO" : "LANJUTKAN",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ),
    );
  }
}
