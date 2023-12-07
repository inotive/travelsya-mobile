import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_filter_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_filter_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/splash_screen/pages/splash_screen_page.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_cubit.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
      ),
      BlocProvider<ProfileCubit>(
        create: (context) => ProfileCubit(),
      ),
      BlocProvider<MainIndexCubit>(
        create: (context) => MainIndexCubit(),
      ),
      BlocProvider<PPOBCubit>(
        create: (context) => PPOBCubit(),
      ),
      BlocProvider<HotelFilterCubit>(
        create: (context) => HotelFilterCubit(),
      ),
      BlocProvider<HostelFilterCubit>(
        create: (context) => HostelFilterCubit(),
      ),
      BlocProvider<FeeAdminCubit>(
        create: (context) => FeeAdminCubit(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travelsya',
        theme: mainTheme,
        home: const SplashScreenPage(),
      );
    });
  }
}
