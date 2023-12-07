import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_state.dart';
import 'package:travelsya/app/auth/model/profile_model.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';

class PointHistorySection extends StatefulWidget {
  const PointHistorySection({Key? key}) : super(key: key);

  @override
  State<PointHistorySection> createState() => _PointHistorySectionState();
}

class _PointHistorySectionState extends State<PointHistorySection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: BlocProvider.of<ProfileCubit>(context),
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            );
          } else if (state is ProfileLoaded) {
            return state.data.point.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          'assets/icons/logo.jpg',
                        ),
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                      Center(
                        child: Text(
                          'Belum Ada Riwayat Point',
                          style: mainBody4,
                        ),
                      ),
                    ],
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<ProfileCubit>(context)
                          .fetchProfile(context);
                    },
                    color: Theme.of(context).primaryColor,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                      children: List.generate(state.data.point.length, (index) {
                        HistoryPoint data = state.data.point[index];

                        return Container(
                          margin: EdgeInsets.only(
                              bottom: state.data.point.length - 1 == index
                                  ? margin32
                                  : margin24 / 2),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: margin16, horizontal: margin16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: neutral10Stroke)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black12,
                                      ),
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: Image.asset(
                                            getPreviewAssetTransaction(data
                                                .transaction.service
                                                .toUpperCase())),
                                      ),
                                    ),
                                    SizedBox(
                                      width: margin16,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${dateToReadable(state.data.point[index].createdAt.substring(0, 10))} ${state.data.point[index].createdAt.substring(11, 19)}',
                                          style: mainBody5.copyWith(),
                                        ),
                                        Text(
                                          state.data.point[index].transaction
                                              .service,
                                          style: mainBody4.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                                    SizedBox(
                                      width: margin8,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 6.0.w,
                                          height: 6.0.w,
                                          child:
                                              Image.asset(ConstHelper.coinIcon),
                                        ),
                                        SizedBox(
                                          width: 1.0.w,
                                        ),
                                        Text(
                                          (data.flow == 'credit' ? '-' : '+') +
                                              (moneyChanger(
                                                  double.parse(
                                                      data.point.toString()),
                                                  customLabel: '')),
                                          style: mainFont.copyWith(
                                              fontSize: 11.0.sp,
                                              color: data.flow == 'credit'
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                            data.flow == 'credit'
                                                ? ConstHelper.redElips
                                                : ConstHelper.greenElips,
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  );
          } else {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: margin16),
              child: FailedRequestWidget(onRetry: () {
                BlocProvider.of<ProfileCubit>(context).fetchProfile(context);
              }),
            );
          }
        });
  }
}
