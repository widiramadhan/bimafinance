// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bima_finance/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<input type="file" accept="image/*" capture>
<input type="file" accept="image/*" capture="user">
<input type="file" accept="image/*" capture="environment">
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

class Absensi extends StatefulWidget {
  final String? title;

  Absensi({Key? key, required this.title});


  @override
  _AbsensiState createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
 final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        useOnDownloadStart: true,
        javaScriptEnabled: true,
        allowFileAccessFromFileURLs: true,
        allowUniversalAccessFromFileURLs: true,
        javaScriptCanOpenWindowsAutomatically: true
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        clearSessionCache: true,
        thirdPartyCookiesEnabled: true,
        allowFileAccess: true,
        allowContentAccess: true
  
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: false,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
          title: Text("${widget.title}", style: TextStyle(color: colorPrimary),),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
          brightness: Brightness.light,
          leading: IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.black,),
              onPressed: () {
                Navigator.pop(context);
              }
          ),
        ),
          body: SafeArea(
              child: Column(children: <Widget>[
                // TextField(
                //   decoration: InputDecoration(
                //       prefixIcon: Icon(Icons.search)
                //   ),
                //   controller: urlController,
                //   keyboardType: TextInputType.url,
                //   onSubmitted: (value) {
                //     var url = Uri.parse(value);
                //     if (url.scheme.isEmpty) {
                //       url = Uri.parse("https://www.google.com/search?q=" + value);
                //     }
                //     webViewController?.loadUrl(
                //         urlRequest: URLRequest(url: url));
                //   },
                // ),
                Expanded(
                  child: Stack(
                    children: [
                      InAppWebView(
                        
                        key: webViewKey,
                        initialUrlRequest:
                        URLRequest(url: Uri.parse("https://bima-absen.epizy.com/login")),
                        
                        
                        initialOptions: options,
                        pullToRefreshController: pullToRefreshController,
                        onWebViewCreated: (controller) async {
                              // add first all of your web message listeners
                              if (!Platform.isAndroid || await AndroidWebViewFeature.isFeatureSupported(AndroidWebViewFeature.WEB_MESSAGE_LISTENER)) {
                                await controller.addWebMessageListener(WebMessageListener(
                                  jsObjectName: "myObject",
                                  allowedOriginRules: Set.from(["https://bima-absen.epizy.com/login"]),
                                  onPostMessage: (message, sourceOrigin, isMainFrame, replyProxy) {
                                    replyProxy.postMessage("Got it!");
                                  },
                                ));
                              }
                              
                              // then load your URL
                              await controller.loadUrl(urlRequest: URLRequest(url: Uri.parse("https://www.example.com")));
  },
                        onLoadStart: (controller, url) {
                          setState(() {
                            this.url = url.toString();
                            urlController.text = this.url;
                          });
                        },
                        androidOnPermissionRequest: (controller, origin, resources) async {
                          return PermissionRequestResponse(
                              resources: resources,
                              action: PermissionRequestResponseAction.GRANT);
                        },
                         androidOnGeolocationPermissionsShowPrompt:
                            (InAppWebViewController controller, String origin) async {
                          return GeolocationPermissionShowPromptResponse(
                            origin: origin,
                            allow: true,
                            retain: true
                          );
                        },
                        shouldOverrideUrlLoading: (controller, navigationAction) async {
                          var uri = navigationAction.request.url!;

                          if (![ "http", "https", "file", "chrome", "location", "camera",
                            "data", "javascript", "about"].contains(uri.scheme)) {
                            if (await canLaunch(url)) {
                              // Launch the App
                              await launch(
                                url,
                              );
                              // and cancel the request
                              return NavigationActionPolicy.CANCEL;
                            }
                          }

                          return NavigationActionPolicy.ALLOW;
                        },
                        onLoadStop: (controller, url) async {
                          pullToRefreshController.endRefreshing();
                          setState(() {
                            this.url = url.toString();
                            urlController.text = this.url;
                          });
                        },
                        onLoadError: (controller, url, code, message) {
                          pullToRefreshController.endRefreshing();
                        },
                        onProgressChanged: (controller, progress) {
                          if (progress == 100) {
                            pullToRefreshController.endRefreshing();
                          }
                          setState(() {
                            this.progress = progress / 100;
                            urlController.text = this.url;
                          });
                        },
                        onUpdateVisitedHistory: (controller, url, androidIsReload) {
                          setState(() {
                            this.url = url.toString();
                            urlController.text = this.url;
                          });
                        },
                        onConsoleMessage: (controller, consoleMessage) {
                          print(consoleMessage);
                        },
                        onDownloadStart: (controller, uri) {
                          print("download");
                        },

                      ),
                      progress < 1.0
                          ? LinearProgressIndicator(value: progress)
                          : Container(),
                    ],
                  ),
                ),

                // ButtonBar(
                //   alignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     ElevatedButton(
                //       child: Icon(Icons.arrow_back),
                //       onPressed: () {
                //         webViewController?.goBack();
                //       },
                //     ),
                //     ElevatedButton(
                //       child: Icon(Icons.arrow_forward),
                //       onPressed: () {
                //         webViewController?.goForward();
                //       },
                //     ),
                //     ElevatedButton(
                //       child: Icon(Icons.refresh),
                //       onPressed: () {
                //         webViewController?.reload();
                //       },
                //     ),
                //   ],
                // ),
                ]
              )
           )
        ),
      );
    }
  }