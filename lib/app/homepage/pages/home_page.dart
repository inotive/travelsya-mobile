import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_state.dart';
import 'package:travelsya/app/homepage/cubits/ads_cubit.dart';
import 'package:travelsya/app/homepage/cubits/ads_state.dart';
import 'package:travelsya/app/homepage/vm/beranda_vm.dart';
import 'package:travelsya/app/homepage/widgets/home_profile_picture_widget.dart';
import 'package:travelsya/app/homepage/widgets/home_saldo_action_widget.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
part '_home_page_balance_section.dart';
part '_home_page_menu_section.dart';
part '_home_page_ads_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BerandaVM>.reactive(viewModelBuilder: () {
      return BerandaVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return StatusbarWidget(
        customBrightness: Brightness.light,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Container(
                padding: EdgeInsets.all(margin16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 90,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(ConstHelper.logoHomeIcon),
                    ),
                    HomeProfilePictureWidget(onProfileTap: () {
                      model.onProfileMenuTap(context, onLoggedFunction: () {
                        BlocProvider.of<MainIndexCubit>(context).changeIndex(4);
                      });
                    })
                  ],
                ),
              ),
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: const EdgeInsets.only(top: 60),
                    padding: const EdgeInsets.only(top: 60),
                    decoration: BoxDecoration(
                        color: neutral10,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: margin24 / 2,
                      ),
                      _HomePageBalanceSection(
                        model: model,
                      ),
                      SizedBox(
                        height: margin24 / 2,
                      ),
                      Expanded(
                          child: RefreshIndicator(
                        onRefresh: () async {
                          model.onInit(context);
                        },
                        color: Theme.of(context).primaryColor,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            SizedBox(
                              height: margin8,
                            ),
                            _HomePageMenuSection(
                              model: model,
                            ),
                            SizedBox(
                              height: margin32,
                            ),
                            GestureDetector(
                              onTap: () async {
                                model.onCSTap(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: margin24 / 2),
                                margin:
                                    EdgeInsets.symmetric(horizontal: margin16),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(ConstHelper.csIcon),
                                    ),
                                    SizedBox(width: margin8),
                                    Text(
                                      'Chat CS',
                                      style: mainBody4.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: margin24,
                            ),
                            _HomePageAdsSection(
                              model: model,
                            ),
                            SizedBox(
                              height: margin72,
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ],
              ))
            ],
          ),
        ),
      );
    });
  }
}
