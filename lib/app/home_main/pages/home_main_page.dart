import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/home_main/viewmodel/home_main_vm.dart';
import 'package:travelsya/app/home_main/widgets/home_bottom_navbar.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/cubits/main_index_state.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeMainVM>.reactive(
        viewModelBuilder: () {
          return HomeMainVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return StatusbarWidget(
            customBrightness: Brightness.light,
            child: Scaffold(
              body: Stack(
                children: [
                  BlocBuilder<MainIndexCubit, MainIndexState>(
                      bloc: BlocProvider.of<MainIndexCubit>(context),
                      builder: (context, state) {
                        if (state is MainIndexLoaded) {
                          return Column(
                            children: [
                              Expanded(child: model.dataScreen[state.data]),
                              HomeBottomNavbar(
                                selectedIndex: state.data,
                                onTap: (value) {
                                  model.onBottomNavBarTap(context, value);
                                },
                              ),
                            ],
                          );
                        }

                        return Container();
                      }),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: margin32,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          model.onQrisTap(context);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset(ConstHelper.qrisIcon),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
