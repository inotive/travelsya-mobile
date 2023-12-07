import 'package:flutter/material.dart';
import 'package:travelsya/shared/widgets/loading_widget.dart';

showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return const LoadingWidget();
      });
}
