import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_state.dart';
import 'package:travelsya/app/home_main/pages/home_main_page.dart';
import 'package:travelsya/app/hostel/models/hostel_detail_model.dart';
import 'package:travelsya/app/hostel/models/hostel_model.dart';
import 'package:travelsya/app/hostel/pages/guest_info_form_page.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/payment/repository/finance_repository.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/date_picker_single.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class HostelOrderPage extends StatefulWidget {
  final HostelDetailModel data;
  final HostelRoom dataRoom;
  final DateTime tanggal;
  final int totalKamar;
  const HostelOrderPage(
      {Key? key,
      required this.dataRoom,
      required this.tanggal,
      required this.totalKamar,
      required this.data})
      : super(key: key);

  @override
  State<HostelOrderPage> createState() => _HostelOrderPageState();
}

class _HostelOrderPageState extends State<HostelOrderPage> {
  List<GuestModel> dataGuest = [];
  int totalPoint = 0;
  late DateTime tanggalFinal;

  @override
  void initState() {
    setState(() {
      tanggalFinal = widget.tanggal;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5.0.w),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 3.0.w,
                  ),
                  Text(
                    'Ringkasan Pesanan',
                    style: mainFont.copyWith(
                        fontSize: 13.0.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   width: 25.0.w,
                          //   height: 17.0.w,
                          //   child: Image.network(widget.data.images[0]),
                          // ),
                          // SizedBox(
                          //   width: 3.0.w,
                          // ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.name,
                                style: mainFont.copyWith(
                                    fontSize: 13.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: neutral100),
                              ),
                              Text(
                                '${widget.totalKamar} x ${widget.dataRoom.bedType}',
                                style: mainFont.copyWith(
                                    fontSize: 9.0.sp, color: neutral100),
                              )
                            ],
                          ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 3.0.w),
                        width: double.infinity,
                        height: 1,
                        color: neutral30.withOpacity(0.3),
                      ),
                      SizedBox(
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 3.0.w),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xfff4f4f4)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Check In',
                                        style: mainFont.copyWith(
                                            fontSize: 8.0.sp,
                                            color: const Color(0xffa5a5a5)),
                                      ),
                                      Text(
                                        dateToReadable(DateFormat('yyyy-MM-dd')
                                            .format(tanggalFinal)),
                                        style: mainFont.copyWith(
                                            fontSize: 10.0.sp,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.data.checkIn,
                                        style: mainFont.copyWith(
                                            fontSize: 9.0.sp,
                                            color: neutral100),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.0.w,
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 3.0.w),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xfff4f4f4)),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Check Out',
                                        style: mainFont.copyWith(
                                            fontSize: 8.0.sp,
                                            color: const Color(0xffa5a5a5)),
                                      ),
                                      // Text(
                                      //   dateToReadable(DateFormat('yyyy-MM-dd')
                                      //       .format(tanggalFinal.add(Duration(
                                      //           days: widget.data.category ==
                                      //                   'Harian'
                                      //               ? 1
                                      //               : widget.data.category ==
                                      //                       'Bulanan'
                                      //                   ? 30
                                      //                   : 365)))),
                                      //   style: mainFont.copyWith(
                                      //       fontSize: 10.0.sp,
                                      //       color: Colors.black87,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      Text(
                                        widget.data.checkOut,
                                        style: mainFont.copyWith(
                                            fontSize: 9.0.sp,
                                            color: neutral100),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.0.w,
                      ),
                      FormHelper.borderButton(context, onTap: () async {
                        DateTime? result = await showDialog(
                            context: context,
                            builder: (context) {
                              return DateSinglePicker(
                                  minDate: DateTime.now(),
                                  selectedDate: tanggalFinal);
                            });

                        if (result != null) {
                          tanggalFinal = result;
                          setState(() {});
                        }
                      }, title: 'Ganti Tanggal Checkin')
                    ],
                  ),
                ),
                // Container(
                //   width: double.infinity,
                //   height: 2.0.w,
                //   color: neutral10,
                // ),
                // Container(
                //   padding: EdgeInsets.all(5.0.w),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Detail Pemesan',
                //         style: mainFont.copyWith(
                //             fontSize: 13.0.sp,
                //             color: neutral100,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       SizedBox(
                //         height: 5.0.w,
                //       ),
                //       FormHelper.optionsCircle(context,
                //           title: 'Sama dengan pemilik akun',
                //           onTap: () {},
                //           status: true),
                //       Container(
                //         margin: EdgeInsets.symmetric(vertical: 3.0.w),
                //         width: double.infinity,
                //         height: 1,
                //         color: neutral30.withOpacity(0.3),
                //       ),
                //       Row(
                //         children: [
                //           FormHelper.optionsCircle(context,
                //               title: 'Tuan', onTap: () {}, status: false),
                //           SizedBox(
                //             width: 3.0.w,
                //           ),
                //           FormHelper.optionsCircle(context,
                //               title: 'Nyonya', onTap: () {}, status: false),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 5.0.w,
                //       ),
                //       FormHelper.titleWithWidget(
                //           title: 'Nama Lengkap',
                //           widget: FormHelper.roundedTextfield(context,
                //               hintText: 'Masukkan nama lengkap Anda',
                //               controller: TextEditingController())),
                //       SizedBox(
                //         height: 1.0.w,
                //       ),
                //       Text(
                //         'Seperti di KTP/SIM/Paspor.',
                //         style: mainFont.copyWith(
                //             fontSize: 8.0.sp, color: neutral30),
                //       ),
                //       SizedBox(
                //         height: 5.0.w,
                //       ),
                //       FormHelper.titleWithWidget(
                //           title: 'Nomor Handphone',
                //           widget: FormHelper.roundedTextfield(context,
                //               prefixIcon: Center(
                //                 widthFactor: 1,
                //                 child: Text(
                //                   '+62',
                //                   style: mainFont.copyWith(
                //                       fontSize: 11.0.sp, color: Colors.black87),
                //                 ),
                //               ),
                //               controller: TextEditingController())),
                //       SizedBox(
                //         height: 5.0.w,
                //       ),
                //       FormHelper.titleWithWidget(
                //           title: 'Email',
                //           widget: FormHelper.roundedTextfield(context,
                //               hintText: 'Masukkan email Anda',
                //               controller: TextEditingController())),
                //     ],
                //   ),
                // ),
                Container(
                  width: double.infinity,
                  height: 2.0.w,
                  color: neutral10,
                ),
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Tamu',
                        style: mainFont.copyWith(
                            fontSize: 13.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 6.0.w,
                            height: 6.0.w,
                            child: Image.asset('assets/icons/users.png'),
                          ),
                          SizedBox(
                            width: 2.0.w,
                          ),
                          Text(
                            '${dataGuest.length}/${widget.totalKamar} Detail tamu terisi',
                            style: mainFont.copyWith(
                                fontSize: 9.0.sp,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            width: 1.0.w,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).primaryColor,
                            size: 4.0.w,
                          ),
                        ],
                      ),
                      dataGuest.isEmpty
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(top: 3.0.w),
                              child: Column(
                                children:
                                    List.generate(dataGuest.length, (index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      padding: EdgeInsets.all(5.0.w),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                dataGuest[index]
                                                    .type
                                                    .toUpperCase(),
                                                style: mainFont.copyWith(
                                                    fontSize: 12.0.sp,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                dataGuest[index].name,
                                                style: mainFont.copyWith(
                                                  fontSize: 11.0.sp,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Text(
                                                dataGuest[index].number,
                                                style: mainFont.copyWith(
                                                  fontSize: 11.0.sp,
                                                  color: Colors.black54,
                                                ),
                                              )
                                            ],
                                          )),
                                          SizedBox(
                                            width: 3.0.w,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              GuestModel? data =
                                                  await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              GuestInfoForm(
                                                                data: dataGuest[
                                                                    index],
                                                              )));

                                              if (data != null) {
                                                dataGuest[index] = data;
                                                setState(() {});
                                              }
                                            },
                                            child: Container(
                                              width: 12.0.w,
                                              height: 12.0.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.orange,
                                              ),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.0.w,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                dataGuest.removeAt(index);
                                              });
                                            },
                                            child: Container(
                                              width: 12.0.w,
                                              height: 12.0.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.red,
                                              ),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                      widget.totalKamar == dataGuest.length
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(top: 5.0.w),
                              child: FormHelper.borderButton(context,
                                  onTap: () async {
                                GuestModel? data = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const GuestInfoForm()));

                                if (data != null) {
                                  dataGuest.add(data);
                                  setState(() {});
                                }
                              }, title: 'Tambah Detail Tamu'),
                            )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 2.0.w,
                  color: neutral10,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.0.w,
                          ),
                          Text(
                            'Poin Travelsya',
                            style: mainFont.copyWith(
                                fontSize: 13.0.sp,
                                color: neutral100,
                                fontWeight: FontWeight.bold),
                          ),
                          BlocBuilder<ProfileCubit, ProfileState>(
                              bloc: BlocProvider.of<ProfileCubit>(context),
                              builder: (context, state) {
                                if (state is ProfileLoaded) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 3.0.w),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        padding: EdgeInsets.all(5.0.w),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 6.0.w,
                                              height: 6.0.w,
                                              child: Image.asset(
                                                  ConstHelper.coinIcon),
                                            ),
                                            SizedBox(
                                              width: 3.0.w,
                                            ),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Points Anda',
                                                  style: mainFont.copyWith(
                                                      fontSize: 8.0.sp,
                                                      color: neutral100),
                                                ),
                                                BlocBuilder<ProfileCubit,
                                                        ProfileState>(
                                                    bloc: BlocProvider.of<
                                                        ProfileCubit>(context),
                                                    builder: (context,
                                                        stateProfile) {
                                                      return Text(
                                                        stateProfile
                                                                is ProfileLoaded
                                                            ? moneyChanger(
                                                                stateProfile
                                                                    .data
                                                                    .user
                                                                    .point
                                                                    .toDouble(),
                                                                customLabel: '')
                                                            : '',
                                                        style:
                                                            mainFont.copyWith(
                                                                fontSize:
                                                                    12.0.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    neutral100),
                                                      );
                                                    }),
                                              ],
                                            )),
                                            SizedBox(
                                              width: 3.0.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (totalPoint == 0) {
                                                  setState(() {
                                                    totalPoint = 10;
                                                  });
                                                } else {
                                                  setState(() {
                                                    totalPoint = 0;
                                                  });
                                                }
                                              },
                                              child: Text(
                                                totalPoint != 0
                                                    ? 'Batal Gunakan Poin'
                                                    : 'Gunakan Poin',
                                                style: mainFont.copyWith(
                                                    fontSize: 9.0.sp,
                                                    color: totalPoint != 0
                                                        ? Colors.orange
                                                        : state.data.user
                                                                    .point >
                                                                0
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              }),
                          SizedBox(
                            height: 5.0.w,
                          ),
                        ])),
                SizedBox(
                  height: 10.0.w,
                )
              ],
            )),
            Container(
              padding: EdgeInsets.all(5.0.w),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: neutral30.withOpacity(0.3)))),
              child: Column(
                children: [
                  totalPoint > 0
                      ? Container(
                          margin: EdgeInsets.only(bottom: 1.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Poin Digunakan',
                                style: mainFont.copyWith(
                                    fontSize: 10.0.sp, color: neutral100),
                              ),
                              Text(
                                moneyChanger(totalPoint.toDouble(),
                                    customLabel: ''),
                                style: mainFont.copyWith(
                                    fontSize: 12.0.sp,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Biaya',
                        style: mainFont.copyWith(
                            fontSize: 10.0.sp, color: neutral100),
                      ),
                      Text(
                        moneyChanger(
                            widget.dataRoom.price.toDouble() *
                                widget.totalKamar,
                            customLabel: 'IDR '),
                        style: mainFont.copyWith(
                            fontSize: 12.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.0.w,
                  ),
                  FormHelper.elevatedButtonBasic(context,
                      enabled: widget.totalKamar == dataGuest.length,
                      onTap: () {
                    showLoading(context);
                    FinanceRepository.paymentRequestHostel(context, data: {
                      "service": "hostel",
                      "payment": "xendit",
                      "hostel_room_id": widget.dataRoom.id.toString(),
                      "price": widget.dataRoom.price.toString(),
                      "namehostel": widget.data.name,
                      "guest": List.generate(dataGuest.length, (index) {
                        return {
                          "type_id": "KTP",
                          "identity": dataGuest[index].number,
                          "name": dataGuest[index].name
                        };
                      }),
                      "fees": [
                        {"type": "admin", "value": 1000},
                        {
                          "type": "point",
                          "value": totalPoint > 0 ? (totalPoint * -1) : 0
                        }
                      ],
                      "start": DateFormat('yyyy-MM-dd').format(tanggalFinal),
                      "end": DateFormat('yyyy-MM-dd')
                          .format(tanggalFinal.add(const Duration(days: 1
                              // days: widget.data.category == 'Harian'
                              //     ? 1
                              //     : widget.data.category == 'Bulanan'
                              //         ? 30
                              //         : 365

                              )))
                    }).then((value) async {
                      Navigator.pop(context);
                      if (value.status == RequestStatus.successRequest) {
                        BlocProvider.of<MainIndexCubit>(context).changeIndex(1);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeMainPage()),
                            (route) => false);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => UserPaymentWebview(
                                      url: value.data,
                                    )));
                      } else {
                        showSnackbar(context,
                            data: value.data ?? 'Gagal membuat link pembayaran',
                            colors: Colors.orange);
                      }
                    });
                  }, title: 'Lanjutkan ke Pembayaran')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
