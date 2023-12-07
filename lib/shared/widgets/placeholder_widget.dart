import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaceHolder extends StatelessWidget {
  final Widget child;
  const PlaceHolder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black87.withOpacity(0.1),
        highlightColor: Colors.white,
        child: child);
  }
}
