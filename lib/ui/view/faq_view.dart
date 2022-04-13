import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/constant/viewstate.dart';
import 'package:bima_finance/core/viewmodel/faq_viewmodel.dart';
import 'package:bima_finance/ui/view/base_view.dart';
import 'package:bima_finance/ui/widget/modal_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'faq_detail_view.dart';

class FaqView extends StatefulWidget {
  @override
  _FaqViewState createState() => _FaqViewState();
}

class _FaqViewState extends State<FaqView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ", style: TextStyle(color: colorPrimary),),
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
      body: BaseView<FaqViewModel>(
        onModelReady: (data) async {
          await data.getFaq(context);
        },
        builder: (context, data, child) {
          return ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: data.faq == null ? Center(
                child: CircularProgressIndicator()) : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        data.faq!.isEmpty ? Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Image.asset("assets/images/empty.png", width: 300,),
                                SizedBox(height: 30,),
                                Text("Data Anda masih kosong", style: TextStyle(fontSize: 16),)
                              ],
                            )
                        ) : ListView.builder(
                            itemCount: data.faq!.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      // RUBAH Route nya disini untuk detail FAQ
                                      builder: (context) => FaqDetailView(data: data.faq![index]),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[300]!, width: 1)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: data.faq![index].faq_logo!,
                                        imageBuilder: (context, imageProvider) => Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: imageProvider, fit: BoxFit.cover),
                                          ),
                                        ),
                                        placeholder: (context, url) => new SkeletonAnimation(
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                            )
                                        ),
                                        errorWidget: (context, url, error) => new Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Center(
                                            child: Icon(
                                                Icons.error
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "${data.faq![index].faq_name}",
                                          style: TextStyle(
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Icon(
                                        FontAwesomeIcons.chevronCircleRight,
                                        color: colorPrimary,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        )
                      ],
                    ),
                  ),
            ),
          );
        }
      )
    );
  }
}
