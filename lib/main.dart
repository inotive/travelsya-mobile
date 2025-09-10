import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_city_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_cubit.dart';
import 'package:travelsya/app/health/cubits/health_city_cubit.dart';
import 'package:travelsya/app/health/cubits/health_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_filter_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_by_location_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_city_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_filter_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_populer_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_filter_cubit.dart';
import 'package:travelsya/app/splash_screen/pages/splash_screen_page.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_cubit.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
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

  Intl.defaultLocale = 'id_ID';
  await initializeDateFormatting('id_ID', null);

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
      // BlocProvider(create: (_) => HotelFilterCubit()..onInit()),
      BlocProvider<HotelCubit>(create: (_) => HotelCubit()),

      BlocProvider(create: (_) => HotelPopulerCubit()),
      BlocProvider(create: (_) => HotelCityCubit()),
      BlocProvider(create: (_) => HotelByLocationCubit()),
      // BlocProvider<HotelFilterCubit>(
      //     create: (_) => HotelFilterCubit()..onInit()),
      BlocProvider<HostelFilterCubit>(
        create: (context) => HostelFilterCubit(),
      ),
      BlocProvider<FeeAdminCubit>(
        create: (context) => FeeAdminCubit(),
      ),
      BlocProvider<PointCubit>(
        create: (context) => PointCubit(),
      ),
      BlocProvider<RentalMobilFilterCubit>(
        create: (context) => RentalMobilFilterCubit(),
      ),
      // BlocProvider<BusFilterCubit>(
      //   create: (context) => BusFilterCubit(),
      // ),
      BlocProvider(create: (_) => BusFilterCubit()..onResetData()),
      BlocProvider(create: (_) => BusCityCubit()),
      BlocProvider(create: (_) => HealthCubit()),
      BlocProvider(create: (_) => HealthCityCubit()),
      // BlocProvider(create: (_) => HotelCityCubit()..fetchCities(context)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travelsya',
      theme: mainTheme,
      home: const SplashScreenPage(),
    );
  }
}
