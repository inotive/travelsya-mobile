import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/splash_screen/vm/splash_vm.dart';
// import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashVM>.reactive(viewModelBuilder: () {
      return SplashVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return StatusbarWidget(
        customBrightness: Brightness.light,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.asset(
              'assets/images/logo_splash_screen.png',
              width: 150,
              height: 150,
            ),
          ),
          // body: Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   decoration: const BoxDecoration(
          //       image: DecorationImage(
          //           fit: BoxFit.cover,
          //           image: AssetImage(ConstHelper.splashScreenImage))),
          // ),
        ),
      );
    });
  }
}
