import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import '../utils/hex_color.dart';

class MyWebView extends StatefulWidget {



  var title;
  var urlStr;

  MyWebView(this.title,this.urlStr);
  // MyWebView(this.title,this.urlStr, {Key? key}) : super(key: key)

  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {

  double lineProgress = 0.0;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(Get.width, kToolbarHeight),
      //   child: AppBar(
      //     backgroundColor: Colors.white,
      //     title: Text(widget.title),
      //     leading: IconButton(
      //       onPressed: () async{
      //         Get.back();
      //       },
      //       icon: Image.asset(
      //         'images/leftarr.png',
      //         color: Colors.black87,
      //         width: 15,
      //         height: 15,
      //       ),
      //     ),
      //     bottom: PreferredSize(
      //       child: _progressBar(lineProgress,context),
      //       preferredSize: Size.fromHeight(3.0),
      //     ),
      //   ),
      // ),
      appBar: AppBar(),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.urlStr,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress)");
            setState(() {

              lineProgress = progress.toDouble()/100;
            });

          },
          javascriptChannels: <JavascriptChannel>{
            // _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  _progressBar(double progress,BuildContext context) {

    return LinearProgressIndicator(
      minHeight: 1.5,
      backgroundColor: Colors.white70.withOpacity(0),
      value: progress == 1.0 ? 0 : progress,
      valueColor: new AlwaysStoppedAnimation<Color>(HexColor('#567BFD')),
    );
  }
}
