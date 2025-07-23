import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/profile/pages/account_detail_page.dart';
import 'package:travelsya/app/profile/pages/change_password_page.dart';
import 'package:travelsya/app/profile/pages/profile_edit_page.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/yes_or_no_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileVM extends BaseViewModel {
  List<Map<String, String>> dataMenu = Platform.isIOS
      ? [
          {
            'id': '0',
            'title': 'Profil Saya',
            'assets': 'assets/icons/user_4.png'
          },
          // {
          //   'id': '1',
          //   'title': 'Data Penumpang',
          //   'assets': 'assets/icons/users (2) 1.png'
          // },
          {'id': '2', 'title': 'Keamanan', 'assets': 'assets/icons/lock_1.png'},
          // {
          //   'id': '3',
          //   'title': 'Kode Referal',
          //   'assets': 'assets/icons/clipboard (2) 1.png'
          // },
          {
            'id': '4',
            'title': 'Kebijakan Refund & Pembatalan',
            'assets': 'assets/icons/credit_card.png'
          },
          {
            'id': '5',
            'title': 'Pusat Bantuan',
            'assets': 'assets/icons/headphones.png'
          },
          {'id': '7', 'title': 'Hapus Akun', 'assets': 'assets/icons/bin.png'},
          {'id': '6', 'title': 'Log out', 'assets': 'assets/icons/log_out.png'},
        ]
      : [
          {
            'id': '0',
            'title': 'Profil Saya',
            'assets': 'assets/icons/user_4.png'
          },
          // {
          //   'id': '1',
          //   'title': 'Data Penumpang',
          //   'assets': 'assets/icons/users (2) 1.png'
          // },
          {'id': '2', 'title': 'Keamanan', 'assets': 'assets/icons/lock_1.png'},
          // {
          //   'id': '3',
          //   'title': 'Kode Referal',
          //   'assets': 'assets/icons/clipboard (2) 1.png'
          // },
          {
            'id': '4',
            'title': 'Kebijakan Refund & Pembatalan',
            'assets': 'assets/icons/credit_card.png'
          },
          {
            'id': '5',
            'title': 'Pusat Bantuan',
            'assets': 'assets/icons/headphones.png'
          },
          {'id': '6', 'title': 'Log out', 'assets': 'assets/icons/log_out.png'},
        ];

  onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const ProfileEditPage()));
    } else if (index == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const ChangePasswordPage()));
    } else if (index == 6) {
      yesOrNoDialog(context,
              title: 'Logout',
              desc: 'Apakah Anda yakin untuk melakukan logout?')
          .then((value) {
        if (value) {
          BlocProvider.of<AuthCubit>(context).logout(context);
        }
      });
    } else if (index == 4) {
      launchUrl(Uri.parse('https://travelsya.com/privasi'),
          mode: LaunchMode.externalApplication);
    } else if (index == 5) {
      launchUrl(Uri.parse('https://travelsya.com/pusat-bantuan'),
          mode: LaunchMode.externalApplication);
    } else if (index == 7) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const AccountDetailPage()));
    } else {
      showSnackbar(context,
          data: 'Coming Soon', colors: Theme.of(context).primaryColor);
    }
  }
}
