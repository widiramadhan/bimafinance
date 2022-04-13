import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/core/model/faq_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skeleton_text/skeleton_text.dart';

class FaqDetailView extends StatefulWidget {
  FaqModel? data;

  FaqDetailView({
    Key? key,
    required this.data
  });

  @override
  _FaqDetailViewState createState() => _FaqDetailViewState();
}

class _FaqDetailViewState extends State<FaqDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("${widget.data!.faq_name}", style: TextStyle(color: colorPrimary),),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.data!.faq_logo!,
                imageBuilder: (context, imageProvider) => Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => new SkeletonAnimation(
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                      ),
                    )
                ),
                errorWidget: (context, url, error) => new Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Icon(
                        Icons.error
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
             
              SizedBox(height: 20,),
              Text("${widget.data!.faq_name}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Html(
                data: """
                  ${widget.data!.faq_instruction},
                      """,
              )

            ],
          ),
        ),
      ),
    );
  }
}
