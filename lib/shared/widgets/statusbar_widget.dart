import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusbarWidget extends StatelessWidget {
  final Widget child;
  final Brightness? customBrightness;
  const StatusbarWidget(
      {super.key, required this.child, this.customBrightness});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: customBrightness ?? Brightness.dark),
        child: child);
  }
}
