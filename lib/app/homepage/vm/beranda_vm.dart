import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/bus/pages/bus_search_page.dart';
import 'package:travelsya/app/health/pages/health_search_page.dart';
import 'package:travelsya/app/homepage/cubits/ads_cubit.dart';
import 'package:travelsya/app/hostel/pages/hostel_search_page/hostel_search_page.dart';
import 'package:travelsya/app/hotel/pages/hotel_search/hotel_search_page.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/pages/bpjs/bpjs_kesehatan_main_page.dart';
import 'package:travelsya/app/ppob/pages/ewallet/ewallet_main_page.dart';
import 'package:travelsya/app/ppob/pages/pajak/pajak_main_page.dart';
import 'package:travelsya/app/ppob/pages/pdam/pdam_main_page.dart';
import 'package:travelsya/app/ppob/pages/pln/pln_main_page.dart';
import 'package:travelsya/app/ppob/pages/pulsa/pulsa_form_page.dart';
import 'package:travelsya/app/ppob/pages/tv_berbayar/tv_berbayar_main_page.dart';
import 'package:travelsya/app/rekreasi/pages/rekreasi_search_page.dart';
import 'package:travelsya/app/rental_mobil/pages/rental_mobil_search_page.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_cubit.dart';
import 'package:travelsya/shared/function/need_login_function.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class BerandaVM extends BaseViewModel {
  AdsCubit adsCubit = AdsCubit();

  List<String> listIklan = [
    'assets/ads/iklan_1.png',
    'assets/ads/iklan_2.png',
    'assets/ads/iklan_3.png',
    'assets/ads/iklan_4.png',
  ];
  List<Map<String, dynamic>> dataMenu = [
    {'title': 'Hotel', 'assets': ConstHelper.hotelIcon, 'id': 1},
    {'title': 'Hostel', 'assets': ConstHelper.hostelIcon, 'id': 7},
    {'title': 'PLN', 'assets': ConstHelper.plnIcon, 'id': 9},
    {'title': 'BPJS', 'assets': ConstHelper.bpjsIcon, 'id': 10},
    {'title': 'PDAM', 'assets': ConstHelper.pdamIcon, 'id': 11},
    {'title': 'E-Wallet', 'assets': ConstHelper.ewalletIcon, 'id': 13},
    {'title': 'Pulsa & Data', 'assets': ConstHelper.pulsaIcon, 'id': 14},
    {'title': 'TV Berbayar', 'assets': ConstHelper.tvIcon, 'id': 15},
    {'title': 'Pajak', 'assets': ConstHelper.taxIcon, 'id': 16},
    {'title': 'Pesawat', 'assets': ConstHelper.planeIcon, 'id': 2},
    {'title': 'Kereta Api', 'assets': ConstHelper.kaIcon, 'id': 3},
    {'title': 'Bus & Travel', 'assets': ConstHelper.busIcon, 'id': 4},
    {'title': 'Rekreasi', 'assets': ConstHelper.rekreasiIcon, 'id': 5},
    {'title': 'Rental Mobil', 'assets': ConstHelper.carIcon, 'id': 6},
    {'title': 'Health & Beauty', 'assets': ConstHelper.healthIcon, 'id': 8},
    {'title': 'Transfer Bank', 'assets': ConstHelper.transferIcon, 'id': 12},
  ];

  bool isDisableMenu(int id) {
    if (id == 2 || id == 3 || id == 12) {
      return true;
    } else {
      return false;
    }
  }

  onInit(BuildContext context) {
    BlocProvider.of<PPOBCubit>(context).fetchPPOBData(context);
    BlocProvider.of<FeeAdminCubit>(context).fetchFeeAdmin(context);
    BlocProvider.of<ProfileCubit>(context).fetchProfile(context);
    adsCubit.fetchAdsData(context);
  }

  onCSTap(BuildContext context) async {
    var contact = "+628115417708";
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Halo CS Travelsya, Saya Butuh Bantuan";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Halo CS Travelsya, Saya Butuh Bantuan')}";

    if (await canLaunchUrl(
        Uri.parse(Platform.isAndroid ? androidUrl : iosUrl))) {
      launchUrl(Uri.parse(Platform.isAndroid ? androidUrl : iosUrl));
    } else {
      if (context.mounted) {
        showSnackbar(context,
            data: 'Gagal Membuka Link Chat CS', colors: Colors.orange);
      }
    }
  }

  onMainMenuTap(BuildContext context, int id) {
    if (id == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HotelSearchPage()));
    } else if (id == 2) {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => PlaneSearchPage()));
    } else if (id == 3) {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => KASearchPage()));
    } else if (id == 4) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const BusSearchPage()));
    } else if (id == 5) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const RekreasiSearchPage()));
    } else if (id == 6) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const RentalSearchPage()));
    } else if (id == 7) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HostelSearchPage()));
    } else if (id == 8) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HealthSearchPage()));
    } else if (id == 9) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const PLNMainPage()));
    } else if (id == 10) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const BPJSKesehatanMainPage()));
    } else if (id == 11) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const PDAMMainPage()));
    } else if (id == 13) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const EwalletMainPage()));
    } else if (id == 14) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const PulsaFormPage()));
    } else if (id == 15) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const TVBerbayarMainPage()));
    } else if (id == 16) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const PajakMainPage()));
    } else {}
  }

  onProfileMenuTap(BuildContext context, {required Function onLoggedFunction}) {
    needLoginFeature(context, () {
      onLoggedFunction();
    });
  }

  onTopupMenuTap(BuildContext context) {
    needLoginFeature(context, () {
      showSnackbar(context,
          data: 'Coming Soon', colors: Theme.of(context).primaryColor);
      // Navigator.push(context, MaterialPageRoute(builder: (_) => TopupPage()));
    });
  }

  onTransferTap(BuildContext context) {
    needLoginFeature(context, () {
      showSnackbar(context,
          data: 'Coming Soon', colors: Theme.of(context).primaryColor);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => TransferPage()));
    });
  }

  onMutasiTap(BuildContext context) {
    needLoginFeature(context, () {
      showSnackbar(context,
          data: 'Coming Soon', colors: Theme.of(context).primaryColor);

      // Navigator.push(context, MaterialPageRoute(builder: (_) => MutasiPage()));
    });
  }
}
