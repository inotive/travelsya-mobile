import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_state.dart';
import 'package:travelsya/app/ppob/models/ppob_general_model.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_cubit.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_state.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/function/need_login_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/failed_request_horizontal_widget.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/split_row_widget.dart';
import 'package:travelsya/shared/widgets/placeholder_widget.dart';

class GeneralInquiryWidget extends StatefulWidget {
  final PPOBInquiryGeneralModel data;
  final PPOBModel ppob;
  final String service;
  final String accountNumber;
  final String uniqueCode;
  const GeneralInquiryWidget(
      {super.key,
      required this.data,
      required this.service,
      required this.ppob,
      required this.uniqueCode,
      required this.accountNumber});

  @override
  State<GeneralInquiryWidget> createState() => _GeneralInquiryWidgetState();
}

class _GeneralInquiryWidgetState extends State<GeneralInquiryWidget> {
  bool usePoint = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        bloc: BlocProvider.of<AuthCubit>(context),
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(margin16),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: neutral10Stroke))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Detail Tagihan',
                        style: mainBody3.copyWith(fontWeight: FontWeight.bold)),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close, color: Colors.black87))
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                children: [
                  SizedBox(
                    height: 3.0.w,
                  ),
                  Text(
                    'Informasi Pelanggan',
                    style: mainBody3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: margin8),
                  SplitRowWidget(
                      data: widget.accountNumber, title: 'No Pelanggan'),
                  SplitRowWidget(data: widget.data.name, title: 'Nama'),
                  SizedBox(
                    height: margin16,
                  ),
                  Text(
                    'Informasi Tagihan',
                    style: mainBody3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: margin8,
                  ),
                  FormHelper.splitRow(
                      data: moneyChanger(widget.data.tagihan),
                      title: 'Tagihan'),
                  BlocBuilder<FeeAdminCubit, FeeAdminState>(
                      bloc: BlocProvider.of<FeeAdminCubit>(context),
                      builder: (context, state) {
                        if (state is FeeAdminLoading) {
                          return PlaceHolder(
                              child: Container(
                            width: double.infinity,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                          ));
                        } else if (state is FeeAdminLoaded) {
                          double finalData = getAdminFeeByService(
                              context, widget.service, widget.data.tagihan);

                          return FormHelper.splitRow(
                              data: moneyChanger(finalData), title: 'Admin');
                        } else {
                          return FailedRequestHorizontalWidget(onRetry: () {
                            BlocProvider.of<FeeAdminCubit>(context)
                                .fetchFeeAdmin(context);
                          });
                        }
                      }),
                  FormHelper.splitRow(
                      data: widget.uniqueCode, title: 'Kode Unik'),
                  SizedBox(height: margin32)
                ],
              )),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: margin24 / 2, horizontal: margin16),
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12))),
                child: Column(
                  children: [
                    BlocBuilder<PointCubit, PointState>(
                        bloc: BlocProvider.of<PointCubit>(context),
                        builder: (context, statePoint) {
                          if (statePoint is PointLoaded) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Poin Travelsya Anda',
                                      style: mainBody5.copyWith(
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      '${moneyChanger(statePoint.data.currentPoint, customLabel: '')} Poin',
                                      style: mainBody5.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: margin4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Poin yang dapat digunakan',
                                      style: mainBody5.copyWith(
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      '${moneyChanger(statePoint.data.pointAvailable, customLabel: '')} Poin',
                                      style: mainBody5.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: margin8,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: margin8),
                                  padding: EdgeInsets.symmetric(
                                      vertical: margin4, horizontal: margin8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.black.withOpacity(0.05)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Tukar ${moneyChanger(statePoint.data.pointAvailable, customLabel: '')} Travelsya Poin',
                                            style: mainBody4.copyWith(
                                                color: usePoint
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                      SizedBox(
                                        width: margin8,
                                      ),
                                      CupertinoSwitch(
                                          value: usePoint,
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          onChanged: (val) {
                                            if (usePoint == false) {
                                              ProfileState state =
                                                  BlocProvider.of<ProfileCubit>(
                                                          context)
                                                      .state;
                                              if (state is ProfileLoaded) {
                                                if (state.data.user.point > 0) {
                                                  setState(() {
                                                    usePoint = !usePoint;
                                                  });
                                                }
                                              }
                                            } else {
                                              setState(() {
                                                usePoint = !usePoint;
                                              });
                                            }
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else if (statePoint is PointLoading) {
                            return SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Gagal Memuat Data Poin',
                                  style:
                                      mainBody5.copyWith(color: Colors.black54),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<PointCubit>(context)
                                        .fetchPoint(context);
                                  },
                                  child: Text(
                                    'Coba Lagi',
                                    style: mainBody5.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                )
                              ],
                            );
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Tagihan',
                          style: mainBody4,
                        ),
                        Text(
                          moneyChanger(widget.data.tagihan +
                              getAdminFeeByService(context, widget.service,
                                  widget.data.tagihan) +
                              double.parse(widget.uniqueCode)),
                          style: mainBody4.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: margin8,
                    ),
                    FormHelper.elevatedButtonBasic(context, enabled: true,
                        onTap: () {
                      needLoginFeature(context, () {
                        Navigator.pop(context, usePoint);
                      });
                    }, title: 'Lanjutkan ke Pembayaran')
                  ],
                ),
              )
            ],
          );
        });
  }
}
