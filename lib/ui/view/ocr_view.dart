import 'dart:io';
import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/helper/nik_validator.dart';
import 'package:bima_finance/ui/view/verification_view.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null) {
      return renderObject!.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}

class OCRView extends StatefulWidget {
  @override
  _OCRViewState createState() => _OCRViewState();
}

class _OCRViewState extends State<OCRView> {
  GlobalKey cameraKey = new GlobalKey();
  GlobalKey headerKey = new GlobalKey();
  GlobalKey cameraWidgetKey = new GlobalKey();
  GlobalKey screenKey = new GlobalKey();
  bool resultSent = false;
  bool _messageTutorial = false;
  final textDetector = GoogleMlKit.vision.textDetector();
  RecognisedText? sourceCam;

  List<CameraDescription>? cameras;
  CameraController? cameraController;
  File? _croppedFile;
  File? _ocrImage;
  InputImage? ocrImage;
  bool _isLoading = false;

  String nik = "";
  String dob = "";
  String gender = "";
  String province = "";
  String city = "";
  String subDistrict = "";
  String postalCode = "";

  @override
  void initState() {
    initCamera();
    super.initState();
  }

  initCamera() async {
    cameras = await availableCameras();
    var camera = cameras!
        .firstWhere((cam) => cam.lensDirection == CameraLensDirection.back);
    cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      onSetFlashModeButtonPressed(FlashMode.off);
      setState(() {});
    });
  }

  Future<XFile?> takePicture() async {
    final CameraController controller = cameraController!;
    if (controller == null || !controller.value.isInitialized) {
      print('Error: select a camera first.');
      return null;
    }

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await controller.takePicture();
      return file;
    } on CameraException catch (e) {
      print(e);
      return null;
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) async {
      if (mounted) {
        XFile imageCaptured;
        File tempImage;
        imageCaptured = file!;
        tempImage = new File(imageCaptured.path);
        ImageProperties properties =
        await FlutterNativeImage.getImageProperties(tempImage.path);
        var heightPhoto;
        var yValue = 0.0;
        if (properties.orientation == ImageOrientation.rotate90) {
          heightPhoto = ((properties.height! / 5) * 4).toInt();
          yValue = ((cameraKey.globalPaintBounds!.top - cameraWidgetKey.globalPaintBounds!.top) / cameraWidgetKey.globalPaintBounds!.height) * 100;
          yValue = (yValue / 100) * properties.width!;
        } else {
          heightPhoto = ((properties.width! / 5) * 4).toInt();
          yValue = ((cameraKey.globalPaintBounds!.top - cameraWidgetKey.globalPaintBounds!.top) / cameraWidgetKey.globalPaintBounds!.height) * 100;
          yValue = (yValue / 100) * properties.height!;
        }
        try {
          if (properties.orientation == ImageOrientation.rotate90) {
            _croppedFile = await FlutterNativeImage.cropImage(
                tempImage.path,
                yValue.round(), // Y
                0, // X
                heightPhoto, // HEIGHT
                properties.height!); // WIDTH
          } else {
            _croppedFile = await FlutterNativeImage.cropImage(
                tempImage.path,
                0, // X
                yValue.round(), // Y
                properties.width!, //WIDTH
                heightPhoto); //HEIGHT
          }
          _ocrImage = _croppedFile;
          ocrImage = InputImage.fromFile(_croppedFile!);

          final recognisedText = await textDetector.processImage(ocrImage!);
          print('recognisedText txt > ${recognisedText.text}');

          RegExp nikRegExp = RegExp(r'^[0-9]{16}');
          sourceCam = recognisedText;
          sourceCam!.blocks.forEach((block) {
            block.lines.forEach((line) async {
              if (nikRegExp.hasMatch(line.text)) {
                setState(() {
                  nik = line.text;
                });
              }
            });
          });
        } catch (e) {
          Toast.show(e.toString(), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
        print("Before compress : ${_croppedFile!.lengthSync()}");
        print(_croppedFile!.path);
        setState(() {});
        if (file != null) print('Picture saved to ${file.path}');
      }
    });
  }

  void onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) setState(() {});
      print('Flash mode set to ${mode.toString().split('.').last}');
    });
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (cameraController == null) {
      return;
    }

    try {
      await cameraController!.setFlashMode(mode);
    } on CameraException catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  void dispose() {
    print('dispose called');
    cameraController?.dispose();
    super.dispose();
  }

  Future processCameraImage(CameraImage image, CameraDescription camera,
      Function(InputImage) onImage) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
    Size(image.width.toDouble(), image.height.toDouble());

    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
    InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    onImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null) {
      return Container();
    }
    if (!cameraController!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Pindai E-KTP", style: TextStyle(color: colorPrimary),),
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
      body: _buildOCR(false, context),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      callback();
    });
  }

  Widget _buildOCR(bool isLoading, BuildContext context) {
    return ModalProgress(
      inAsyncCall: isLoading,
      child: Container(
          key: screenKey,
          width: double.infinity,
          height: double.infinity,
          child: ModalProgress(
            inAsyncCall: _isLoading,
            child: Scaffold(
              body: Stack(
                children: [
                  _cameraPreview(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.black.withOpacity(0.45),
                            )
                        ),
                        if(_messageTutorial == true) ...[
                          AspectRatio(
                            key: cameraKey,
                            aspectRatio: 5 / 4,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.45),
                                BlendMode.srcOut,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 40),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.black.withOpacity(0.45),
                            )
                        ),
                      ],
                    ),
                  ),

                  // IconButton(
                  //   icon: Icon(
                  //     Icons.arrow_back_ios,
                  //     color: Colors.white,
                  //   ),
                  //   onPressed: () {
                  //     Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => CreditApplyView(),
                  //       ),
                  //     );
                  //   },
                  // ),
                  Positioned(
                    bottom: 50,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          if(_messageTutorial == false) ...[
                            Container(
                              padding: EdgeInsets.all(30),
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Pastikan KTP sesuai dengan area yang\ntersedia dan usahakan gambar terlihat\njelas",
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 30,),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _messageTutorial = true;
                                      });
                                    },
                                    child: Text(
                                      "OK, Saya Mengerti",
                                      style: TextStyle(
                                          color: colorPrimary,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20,)
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black, width: 2),
                                    ),
                                    child: IconButton(
                                        onPressed: _messageTutorial == false ? null : () async {
                                          onTakePictureButtonPressed();
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          //nik = "3216072005920012";
                                          NIKModel result = await NIKValidator.instance.parse(nik: nik);
                                          /// When nik is valid
                                          if (result.valid!) {
                                            print("NIK: ${result.nik}");
                                            print("UNIQUE CODE: ${result.uniqueCode}");
                                            print("GENDER: ${result.gender}");
                                            print("BORNDATE: ${result.bornDate}");
                                            print("AGE: ${result.age}");
                                            print("NEXT BIRTHDAY: ${result.nextBirthday}");
                                            print("ZODIAC: ${result.zodiac}");
                                            print("PROVINCE: ${result.province}");
                                            print("CITY: ${result.city}");
                                            print("SUBDISTRICT: ${result.subdistrict}");
                                            print("POSTAL CODE: ${result.postalCode}");

                                            setState(() {
                                              dob = result.bornDate!;
                                              gender = result.gender!;
                                              province = result.province!;
                                              city = result.city!;
                                              subDistrict = result.subdistrict!;
                                              postalCode = result.postalCode!;
                                            });
                                          }
                                          if(nik != ""){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => VerificationView(
                                                  nik: "${nik}",
                                                  name: "",
                                                  dob: "${dob}",
                                                  gender: "${gender}",
                                                  address: "",
                                                  province: '${province}',
                                                  city: '${city}',
                                                  subDistrict: '${subDistrict}',
                                                  postalCode: '${postalCode}',
                                                  ktpPhoto: _croppedFile,
                                                ),
                                              ),
                                            );
                                          } else {
                                            Toast.show("Foto KTP kurang jelas, silahkan coba lagi", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          color: colorPrimary,
                                        )
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget _cameraPreview() {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Container();
    }
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      key: cameraWidgetKey,
      child: CameraPreview(
        cameraController!,
      ),
    );
  }
}
