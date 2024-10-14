import 'package:flutter/material.dart';

class UserPaymentWebview extends StatefulWidget {
  final String url;

  const UserPaymentWebview({
    super.key,
    required this.url,
  });

  @override
  State<UserPaymentWebview> createState() => _UserPaymentWebviewState();
}

class _UserPaymentWebviewState extends State<UserPaymentWebview> {
  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) wv.WebView.platform = wv.AndroidWebView();
  }

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Container();
    // return WillPopScope(
    //   onWillPop: () async {
    //     DateTime now = DateTime.now();
    //     if (currentBackPressTime == null ||
    //         now.difference(currentBackPressTime!) >
    //             const Duration(seconds: 2)) {
    //       currentBackPressTime = now;
    //       showSnackbar(context,
    //           data: 'Tekan sekali lagi untuk keluar dari halaman pembayaran',
    //           colors: Colors.black);

    //       return Future.value(false);
    //     }
    //     return Future.value(true);
    //   },
    //   child: SafeArea(
    //     child: Scaffold(
    //         body: Column(children: [
    //       Expanded(
    //           child: wv.WebViewWidget(
    //         initialUrl: widget.url,
    //         javascriptMode: wv.JavascriptMode.unrestricted,
    //         onWebViewCreated: (wv.WebViewController webViewController) {
    //           _controller.complete(webViewController);
    //         },
    //         // ignore: prefer_collection_literals
    //         javascriptChannels: <wv.JavascriptChannel>[].toSet(),
    //         onPageFinished: (value) async {
    //           devPint('direct to');
    //           devPint(value);
    //           if (value.contains('xendit/succes') ||
    //               value.contains('xendit-success') ||
    //               value.contains('xendit-payment/nextSuccess')) {
    //             http.get(Uri.parse(value));
    //             showSnackbar(context,
    //                 data: 'Pembayaran Berhasil', colors: Colors.green);

    //             Navigator.pop(context, true);
    //           }
    //         },
    //       ))
    //     ])),
    //   ),
    // );
  }
}
