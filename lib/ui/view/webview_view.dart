import 'package:bima_finance/core/constant/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewView extends StatefulWidget {
  final String? title;
  final String? url;

  WebviewView({Key? key, required this.title, required this.url});

  @override
  _WebviewViewState createState() => _WebviewViewState();
}

class _WebviewViewState extends State<WebviewView> {
  final TextEditingController _searchController = TextEditingController();
  var focusNode = FocusNode();
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar(
          title: Text("${widget.title}", style: TextStyle(color: colorPrimary),),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          brightness: Brightness.light,
          leading: IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.black,),
              onPressed: () {
                Navigator.pop(context);
              }
          ),
        ),
        body: isLoading == true ? Center(child: CircularProgressIndicator(),) : Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
            // onProgress: (value) {
            //   setState(() {
            //     isLoading = true;
            //   });
            // },
            // onPageStarted: (value) {
            //   setState(() {
            //     isLoading = true;
            //   });
            // },
          ),
        )
    );
  }
}
