import 'dart:async';
import 'dart:io';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:webview_flutter/webview_flutter.dart' as wv;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserPaymentWebview extends StatefulWidget {
  final String url;

  const UserPaymentWebview({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<UserPaymentWebview> createState() => _UserPaymentWebviewState();
}

class _UserPaymentWebviewState extends State<UserPaymentWebview> {
  final Completer<wv.WebViewController> _controller =
      Completer<wv.WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) wv.WebView.platform = wv.AndroidWebView();
  }

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 2)) {
          currentBackPressTime = now;
          showSnackbar(context,
              data: 'Tekan sekali lagi untuk keluar dari halaman pembayaran',
              colors: Colors.black);

          return Future.value(false);
        }
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
            body: Column(children: [
          Expanded(
              child: wv.WebView(
            initialUrl: widget.url,
            javascriptMode: wv.JavascriptMode.unrestricted,
            onWebViewCreated: (wv.WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            javascriptChannels: <wv.JavascriptChannel>[].toSet(),
            onPageFinished: (value) async {
              print('direct to');
              print(value);
              if (value.contains('xendit/succes') ||
                  value.contains('xendit-success') ||
                  value.contains('xendit-payment/nextSuccess')) {
                http.get(Uri.parse(value));
                showSnackbar(context,
                    data: 'Pembayaran Berhasil', colors: Colors.green);

                Navigator.pop(context, true);
              }
            },
          ))
        ])),
      ),
    );
  }
}
