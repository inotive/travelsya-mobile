import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:sizer/sizer.dart';

class QRISPage extends StatefulWidget {
  const QRISPage({Key? key}) : super(key: key);

  @override
  State<QRISPage> createState() => _QRISPageState();
}

class _QRISPageState extends State<QRISPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;

    return SafeArea(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(5.0.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 3.0.w,
                  ),
                  Expanded(
                      child: Text(
                    'Scan QRIS',
                    style: mainFont.copyWith(
                        fontSize: 13.0.sp,
                        color: neutral100,
                        fontWeight: FontWeight.bold),
                  ))
                ],
              )),
          Expanded(
              child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0.w),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Powered by',
                  style: mainFont.copyWith(
                      fontSize: 10.0.sp,
                      color: neutral100,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 1.0.w,
                ),
                SizedBox(
                  width: 25.0.w,
                  child: Image.asset('assets/icons/image 15.png'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
