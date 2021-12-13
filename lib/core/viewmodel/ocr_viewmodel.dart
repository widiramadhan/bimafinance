import 'dart:io';

import 'package:bima_finance/core/helper/nik_validator.dart';
import 'package:bima_finance/core/viewmodel/base_viemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class OCRViewModel extends BaseViewModel {
  final textDetector = GoogleMlKit.vision.textDetector();
  RecognisedText? sourceCam;
  String docNik = "";
  String docName = "";
  String docBirthDate = "";
  String docAddress = "";
  String docRT = "";
  String docRW = "";
  String docSubDistrict = "";
  String docReligion = "";

  Future _scanOCR(InputImage ocrImage, BuildContext context) async{
    final recognisedText = await textDetector.processImage(ocrImage);
    print('recognisedText txt > ${recognisedText.text}');

    RegExp nikRegExp = RegExp(r'^[0-9]{16}');
    sourceCam = recognisedText;
    sourceCam!.blocks.forEach((block) {
      block.lines.forEach((line) async {
        if (docNik == '' || docNik == null) {
          if (nikRegExp.hasMatch(line.text)) {
            docNik = line.text;
            NIKModel result = await NIKValidator.instance.parse(nik: docNik);
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
            }
          }
        }
      });
    });
    // var result = findEl('NIK');
    // if (result != null) {
    //   result = result.replaceAll(RegExp('[^0-9]'), '');
    //   if (nikRegExp.hasMatch(result)) {
    //     docNik = result;
    //     await searchDataFromNIK(result);
    //   }
    // } else {
    //   result = findNextLine('NIK');
    //   if (result != null) {
    //     result = result.replaceAll(RegExp('[^0-9]'), '');
    //     if (nikRegExp.hasMatch(result)) {
    //       docNik = result;
    //       await searchDataFromNIK(result);
    //     }
    //   }
    // }
    //
    // var name = findNextLine('Nama');
    // if (name != null) {
    //   name = name.replaceAll(RegExp('[^\\ A-Za-z]'), '');
    //   docName = name;
    // } else {
    //   name = findEl('Nama');
    //   if (name != null) {
    //     name = name.replaceAll(RegExp('[^\\ A-Za-z]'), '');
    //     docName = name;
    //   }
    // }
    //
    // var address = findNextLine('Alamat');
    // if (address != null) {
    //   address = address.replaceAll(RegExp('[^\\ A-Za-z]'), '');
    //   docAddress = address;
    // } else {
    //   address = findNextLine('Aiamat');
    //   if (address != null) {
    //     address = address.replaceAll(RegExp('[^\\ A-Za-z]'), '');
    //     docAddress = address;
    //   }
    // }
    // // else {
    // //   address = findEl('Alamat');
    // //   if (address != null) {
    // //     address = address.replaceAll(RegExp('[^\\ A-Za-z]'), '');
    // //     registerController.docAddress.value = address;
    // //   }
    // // }
    //
    // var rtRw = findNextLine('RTRW');
    // if (rtRw != null) {
    //   rtRw = rtRw.replaceAll(RegExp('[^\\ 0-9]'), '');
    //   docRT = rtRw.substring(0, 3);
    //   docRW = rtRw.substring(3, 6);
    // } else {
    //   rtRw = findNextLine('RT/RW');
    //   if (rtRw != null) {
    //     rtRw = rtRw.replaceAll(RegExp('[^\\ 0-9]'), '');
    //     docRT = rtRw.substring(0, 3);
    //     docRW = rtRw.substring(3, 6);
    //   }
    // }
    // //  else {
    // //   rtRw = findEl('RTRW');
    // //   if (rtRw != null) {
    // //     rtRw = rtRw.replaceAll(RegExp('[^\\ 0-9]'), '');
    // //     registerController.docRt.value = rtRw.substring(0, 3);
    // //     registerController.docRw.value = rtRw.substring(3, 6);
    // //   }
    // // }
    //
    // var subDistrict = findNextLine('Kel');
    // print('Kel : $subDistrict');
    // if (subDistrict != null) {
    //   subDistrict = subDistrict.replaceAll(RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"), '');
    //   docSubDistrict = subDistrict;
    // } else {
    //   subDistrict = findNextLine('Desa');
    //   print('Desa : $subDistrict');
    //   if (subDistrict != null) {
    //     subDistrict = subDistrict.replaceAll(RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"), '');
    //     docSubDistrict = subDistrict;
    //   }
    // }
    //
    // var religion = findNextLine('Agama');
    // if (religion != null) {
    //   religion = religion.replaceAll(RegExp('[^\\ A-Za-z]'), '');
    //   if (religion.toLowerCase().contains('lam')) {
    //     docReligion = 'Muslim';
    //   } else if (religion.toLowerCase().contains('pro')) {
    //     docReligion = 'Protestan';
    //   } else if (religion.toLowerCase().contains('kha')) {
    //     docReligion = 'Katolik';
    //   } else if (religion.toLowerCase().contains('khong')) {
    //     docReligion = 'Khonghucu';
    //   } else if (religion.toLowerCase().contains('bhu')) {
    //     docReligion = 'Budha';
    //   } else if (religion.toLowerCase().contains('hin')) {
    //     docReligion = 'Hindu';
    //   } else {
    //     docReligion = 'Other';
    //   }
    // }
  }

  String? findEl(String keyword) {
    String? result;
    sourceCam?.blocks.asMap().forEach((index, el) {
      // print('index ke-$index | text => ${sourceCam?.blocks[index].text} | length => ${sourceCam?.blocks[index].lines.length}');
      if (el.text.toLowerCase().contains(keyword.toLowerCase())) {
        if (el.lines.length > 1) {
          result = el.lines[1].text;
        } else {
          if (index != sourceCam?.blocks.length) result = sourceCam?.blocks[index + 1].text;
        }
      }
      el.lines.forEach((line) {
        // print('index block => $index | text line => ${line.text}');
      });
    });
    return result;
  }

  String? findNextElement(String key) {
    String? result;
    if (sourceCam!.text.toLowerCase().contains(key.toLowerCase())) {
      print('-------------------------$key-------------------------}');
      try {
        var block = sourceCam!.blocks.firstWhere((element) => element.text.toLowerCase().contains(key.toLowerCase()));
        var line = block.lines.firstWhere((element) => element.text.toLowerCase().contains(key.toLowerCase()));
        if (line.elements.length > 1) {
          var value = line.elements[1].text;
          print('Key: $key');
          print('Value: $value');
          result = value;
        }
      } catch (e) {
        return null;
      }
    }
    return result;
  }

  String? findNextLine(String key) {
    String? result;
    if (sourceCam!.text.toLowerCase().contains(key.toLowerCase())) {
      try {
        var block = sourceCam!.blocks.firstWhere((element) => element.text.toLowerCase().contains(key.toLowerCase()));
        int indexKey = block.lines.indexWhere((element) => element.text.toLowerCase().contains(key.toLowerCase()));
        print('Key: $key');
        print("Box 0 : ${block.lines[indexKey].cornerPoints[0].dx}, ${block.lines[indexKey].cornerPoints[0].dy}");
        print("Box 1 : ${block.lines[indexKey].cornerPoints[1].dx}, ${block.lines[indexKey].cornerPoints[1].dy}");
        print("Box 2 : ${block.lines[indexKey].cornerPoints[2].dx}, ${block.lines[indexKey].cornerPoints[2].dy}");
        print("Box 3 : ${block.lines[indexKey].cornerPoints[3].dx}, ${block.lines[indexKey].cornerPoints[3].dy}");
        var y1 = block.lines[indexKey].cornerPoints[0].dy;
        var y2 = block.lines[indexKey].cornerPoints[1].dy;
        var y3 = block.lines[indexKey].cornerPoints[2].dy;
        var y4 = block.lines[indexKey].cornerPoints[3].dy;
        sourceCam!.blocks.forEach((block) {
          block.lines.forEach((line) {
            if (!line.text.toLowerCase().contains(key.toLowerCase())) {
              if (isInlineText(y1, line.cornerPoints[0].dy) && isInlineText(y2, line.cornerPoints[1].dy) && isInlineText(y3, line.cornerPoints[2].dy) && isInlineText(y4, line.cornerPoints[3].dy)) {
                print('Value: ${line.text}');
                print("Box 0 : ${line.cornerPoints[0].dx}, ${line.cornerPoints[0].dy}");
                print("Box 1 : ${line.cornerPoints[1].dx}, ${line.cornerPoints[1].dy}");
                print("Box 2 : ${line.cornerPoints[2].dx}, ${line.cornerPoints[2].dy}");
                print("Box 3 : ${line.cornerPoints[3].dx}, ${line.cornerPoints[3].dy}");
                result = line.text;
              }
            }
          });
        });
      } catch (e) {
        return null;
      }
    }
    return result;
  }

  bool isInlineText(double y1, double y2) {
    var diff = y1 - y2;
    return diff.abs() < 6;
  }
}