import 'package:flutter/material.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

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
  }

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (data, data2) async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 2)) {
          currentBackPressTime = now;
          showSnackbar(context,
              data: 'Tekan sekali lagi untuk keluar dari halaman pembayaran',
              colors: Colors.black);
        }
      },
      child: SafeArea(
        child: Scaffold(
            body: Column(children: [
          Expanded(
              child: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String value) {
                    devPint('direct to');
                    devPint(value);
                    if (value.contains('xendit/succes') ||
                        value.contains('xendit-success') ||
                        value.contains('xendit-payment/nextSuccess')) {
                      http.get(Uri.parse(value));
                      showSnackbar(context,
                          data: 'Pembayaran Berhasil', colors: Colors.green);

                      Navigator.pop(context, true);
                    }
                  },
                  onHttpError: (HttpResponseError error) {},
                  onWebResourceError: (WebResourceError error) {},
                ),
              )
              ..loadRequest(Uri.parse(widget.url)),
          ))
        ])),
      ),
    );
  }
}
