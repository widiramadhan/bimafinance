// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class MainFileUpload extends StatefulWidget {
//   final String title;
//   final FileUploadResult? value;
//   final Function(FileUploadResult?)? onChanged;
//   final bool readOnly;
//   final String hint;
//   final int maxSize;
//
//   const MainFileUpload({
//     Key? key,
//     required this.title,
//     this.value,
//     this.readOnly = false,
//     this.onChanged,
//     this.hint = 'Format file .jpeg, .jpg dan .png',
//     this.maxSize = 256,
//   }) : super(key: key);
//
//   @override
//   _MainFileUploadState createState() => _MainFileUploadState();
// }
//
// class _MainFileUploadState extends State<MainFileUpload> {
//   String fileName = '';
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (widget.value != null) {
//       fileName = widget.value!.fileName;
//     }
//   }
//
//   Future<FileUploadResult?> getImage({ImageSource source = ImageSource.gallery}) async {
//     final File? pickedFile = await _picker.pickImage(source: source);
//
//     if (pickedFile != null) {
//       fileName = "Memproses gambar";
//
//       //var img = await cb.CBCompressionUtils.compressToMaxSize(File(pickedFile.path), widget.maxSize * 1000);
//
//       fileName = pickedFile.path.split('/').last;
//
//       return FileUploadResult(fileName: fileName, base64Value: base64Encode(img));
//     } else {
//       fileName = '';
//       print('No image selected.');
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(
//           widget.title,
//           style: TextStyle(color: Colors.grey,),
//         ),
//         SizedBox(height: 10),
//         widget.readOnly
//             ? SizedBox()
//             : InkWell(
//                 onTap: () async {
//                   FocusScope.of(context).requestFocus(FocusNode());
//                   DialogUtils.showGeneralDrawer(
//                       content: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Card(
//                         child: InkWell(
//                           onTap: () async {
//                             cb.Get.back();
//                             FileUploadResult? result = await getImage();
//                             widget.onChanged!(result);
//                             // if (result != null) {
//                             // } else {
//                             //   widget.onChanged(null)
//                             // }
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 Icon(Icons.image),
//                                 Text(
//                                   DigitalIdLang.widgetFileUploadGallery.tr,
//                                   style: QoinDigitalId.theme.textTheme.bodyText1,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Card(
//                         child: InkWell(
//                           onTap: () async {
//                             cb.Get.back();
//                             FileUploadResult? result = await getImage(source: ImageSource.camera);
//                             widget.onChanged!(result);
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 Icon(Icons.camera_alt),
//                                 Text(
//                                   DigitalIdLang.widgetFileUploadCamera.tr,
//                                   style: QoinDigitalId.theme.textTheme.bodyText1,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ));
//                 },
//                 child: DottedBorder(
//                     radius: Radius.circular(4),
//                     color: Color(0xffdedede),
//                     strokeWidth: 1,
//                     borderType: BorderType.RRect,
//                     dashPattern: [6, 4],
//                     child: Container(
//                       padding: EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                         color: Color(0xfff5f6f8),
//                         borderRadius: BorderRadius.all(Radius.circular(4)),
//                       ),
//                       child: cb.Obx(
//                         () => Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             fileName.value.length > 0
//                                 ? Expanded(
//                                     flex: 1,
//                                     child: Text(
//                                       fileName.value,
//                                       style: QoinDigitalId.theme.textTheme.bodyText1!
//                                           .copyWith(
//                                             fontWeight: FontWeight.w600,
//                                           )
//                                           .toResponsive(),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   )
//                                 : Icon(
//                                     Icons.photo_camera,
//                                     color: Colors.grey,
//                                   ),
//                             ResponsiveWidget(
//                               width: 5,
//                             ),
//                             if (fileName.value.length > 0) ...[
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Text(
//                                   DigitalIdLang.widgetFileUploadChange.tr,
//                                   style: QoinDigitalId.theme.textTheme.bodyText1!.copyWith(color: Color(0xfff7b500)),
//                                 ),
//                               )
//                             ] else ...[
//                               Text(
//                                 DigitalIdLang.widgetFileUploadTextUpload.tr,
//                                 style: QoinDigitalId.theme.textTheme.bodyText1,
//                               ),
//                             ]
//                           ],
//                         ),
//                       ),
//                     )),
//               ),
//       ],
//     );
//   }
// }
//
// class FileUploadResult {
//   final String fileName;
//   final String base64Value;
//
//   FileUploadResult({required this.fileName, required this.base64Value});
//
//   Map<String, dynamic> toJson() {
//     return {
//       "fileName": fileName,
//       "base64Value": base64Value,
//     };
//   }
//
//   static FileUploadResult fromJson(Map<String, dynamic> json) {
//     return FileUploadResult(
//       fileName: json["fileName"],
//       base64Value: json["base64Value"],
//     );
//   }
// }
