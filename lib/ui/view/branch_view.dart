import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/ui/widget/main_button.dart';
import 'package:bima_finance/ui/widget/textfield_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:toast/toast.dart';

class BranchView extends StatefulWidget {
  @override
  _BranchViewState createState() => _BranchViewState();
}

class _BranchViewState extends State<BranchView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kantor Cabang", style: TextStyle(color: colorPrimary),),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget(
                hintText: 'Cari Kantor Cabang',
                radius: 50,
                suffixIcon: GestureDetector(
                  onTap: () {
                    Toast.show("Fitur ini belum tersedia", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey[300]!)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/branch_1.jpeg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "BEKASI",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  "Ruko Patriot Square Kav 21 Jl. Patriot Raya 14, RT 005/RW 6B, Kelurahan Jakasampurna, Kecamatan Bekasi Barat, Kota Bekasi, Provinsi Jawa Barat",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 20,),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: MainButton(
                                      text: "Lihat di Peta",
                                      onPressed: null,
                                      textColor: colorPrimary,
                                      borderColor: colorPrimary,
                                      color: Colors.white,
                                      radius: 10,
                                      width: 150,
                                      height: 30,
                                    )
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
