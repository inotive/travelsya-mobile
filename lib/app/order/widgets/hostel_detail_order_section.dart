import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/app/hostel/models/hostel_detail_model.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/order/models/order_detail_model.dart';
import 'package:travelsya/app/order/pages/review_hunian_page.dart';
import 'package:travelsya/app/order/widgets/detail_order_split_data_widget.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/failed_request_horizontal_widget.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/placeholder_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HostelDetailOrderSection extends StatefulWidget {
  final OrderDetailHostelModel data;
  const HostelDetailOrderSection({super.key, required this.data});

  @override
  State<HostelDetailOrderSection> createState() =>
      _HostelDetailOrderSectionState();
}

class _HostelDetailOrderSectionState extends State<HostelDetailOrderSection> {
  HostelCubit hostelCubit = HostelCubit();

  @override
  void initState() {
    hostelCubit.fetchDetailHostel(context,
        id: widget.data.hostelId.toString(), durationType: 'monthly');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: margin16, vertical: margin24),
          child: Column(
            children: [
              Row(
                children: [
                  BlocBuilder<HostelCubit, HostelState>(
                      bloc: hostelCubit,
                      builder: (context, state) {
                        if (state is DetailHostelLoaded) {
                          return SizedBox(
                            width: 100,
                            height: 60,
                            child: state.data.image == null
                                ? Image.asset(
                                    'assets/icons/logo.jpg',
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    state.data.image!,
                                    fit: BoxFit.cover,
                                  ),
                          );
                        }

                        return Container();
                      }),
                  SizedBox(
                    width: margin16,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.hostelName,
                        style: mainBody3.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.data.room} x ${widget.data.hostelRoomName}',
                        style: mainBody5,
                      )
                    ],
                  ))
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: margin16),
                width: double.infinity,
                height: 1,
                color: neutral10Stroke,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: margin24 / 2,
                    bottom: margin8,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: margin24 / 2),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xfff4f4f4)),
                            child: Column(
                              children: [
                                Text(
                                  'Check In',
                                  style: mainBody5.copyWith(
                                      color: const Color(0xffa5a5a5)),
                                ),
                                Text(
                                  dateToReadable(widget.data.startDate),
                                  style: mainBody4.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: margin24 / 2),
                          height: double.infinity,
                          width: 1,
                          color: const Color(0xffa5a5a5),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: margin24 / 2),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xfff4f4f4)),
                            child: Column(
                              children: [
                                Text(
                                  'Check Out',
                                  style: mainBody5.copyWith(
                                      color: const Color(0xffa5a5a5)),
                                ),
                                Text(
                                  dateToReadable(widget.data.endDate),
                                  style: mainBody4.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: margin8,
          color: neutral10Stroke.withOpacity(0.3),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: margin24, horizontal: margin16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Tamu',
                style: mainBody3.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: margin16,
              ),
              DetailOrderSplitDataWidget(
                title: 'Total Tamu',
                data: '${widget.data.guest} Tamu',
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Tamu Utama',
                data: widget.data.guestName,
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'No Handphone',
                data: widget.data.guestPhone,
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: margin8,
          color: neutral10Stroke.withOpacity(0.3),
        ),
        BlocBuilder<HostelCubit, HostelState>(
            bloc: hostelCubit,
            builder: (context, state) {
              if (state is DetailHostelLoaded) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: margin24),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: margin16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Lokasi',
                                  style: mainBody3.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                state.data.latitude != null &&
                                        state.data.longitude != null
                                    ? GestureDetector(
                                        onTap: () async {
                                          final url =
                                              'https://www.google.com/maps/search/?api=1&query=${state.data.latitude},${state.data.longitude}';
                                          if (await canLaunchUrl(
                                              Uri.parse(url))) {
                                            await launchUrl(Uri.parse(url),
                                                mode: LaunchMode
                                                    .externalApplication);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: Text(
                                          'Buka di Map',
                                          style: mainFont.copyWith(
                                              fontSize: 11.0.sp,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                          SizedBox(
                            height: margin16,
                          ),
                          AspectRatio(
                            aspectRatio: 375 / 142,
                            child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: FlutterMap(
                                    options: MapOptions(
                                      center: (state.data.latitude != null &&
                                              state.data.longitude != null)
                                          ? LatLng(
                                              double.parse(
                                                  state.data.latitude!),
                                              double.parse(
                                                  state.data.longitude!))
                                          : LatLng(-6.906725572061223,
                                              107.59823247747369),
                                      zoom: 7,
                                    ),
                                    children: (state.data.latitude != null &&
                                            state.data.longitude != null)
                                        ? [
                                            TileLayer(
                                              urlTemplate:
                                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                              userAgentPackageName:
                                                  'dev.fleaflet.flutter_map.example',
                                            ),
                                            MarkerLayer(
                                              markers: [
                                                Marker(
                                                    width: 50,
                                                    height: 70,
                                                    point: LatLng(
                                                        double.parse(state
                                                            .data.latitude!),
                                                        double.parse(state
                                                            .data.longitude!)),
                                                    builder: (context) {
                                                      return Icon(
                                                        Icons.location_on,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 40,
                                                      );
                                                    })
                                              ],
                                            )
                                          ]
                                        : [
                                            TileLayer(
                                              urlTemplate:
                                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                              userAgentPackageName:
                                                  'dev.fleaflet.flutter_map.example',
                                            ),
                                          ])),
                          ),
                          SizedBox(
                            height: margin16,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: margin16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.map_outlined,
                                  color: Colors.grey,
                                  size: margin16,
                                ),
                                SizedBox(
                                  width: margin24 / 2,
                                ),
                                Expanded(
                                    child: Text(
                                  state.data.address ?? '-',
                                  style: mainBody5.copyWith(
                                      fontStyle: FontStyle.normal,
                                      color: const Color(0xff333333)),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: margin8,
                      color: neutral10Stroke.withOpacity(0.3),
                    ),
                  ],
                );
              }

              return Container();
            }),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: margin24, horizontal: margin16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rincian Pembayaran',
                style: mainBody3.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: margin16,
              ),
              SizedBox(
                height: margin16,
              ),
              DetailOrderSplitDataWidget(
                title: 'Status Transaksi',
                data: '',
                customWidget: getTransactionLabel(widget.data.status),
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Tanggal Transaksi',
                data: widget.data.createdAt == null
                    ? '-'
                    : '${dateToReadable(widget.data.createdAt!.substring(0, 10))} ${widget.data.createdAt!.substring(11, 16)}',
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Metode Pembayaran',
                data:
                    "${widget.data.paymentMethod ?? '-'} ${widget.data.paymentChannel == null ? '' : '- ${widget.data.paymentChannel}'}",
              ),
              SizedBox(
                height: margin4,
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Poin Digunakan',
                data: widget.data.pointUsed == 0
                    ? '-'
                    : "-${moneyChanger(widget.data.pointUsed, customLabel: '')}",
                customDataStyle: mainBody5.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Total Bayar',
                data: moneyChanger(widget.data.total),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: margin8,
          color: neutral10Stroke.withOpacity(0.3),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: margin16, vertical: margin24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Biaya',
                    style: mainBody4,
                  ),
                  Text(
                    moneyChanger(widget.data.total, customLabel: 'IDR'),
                    style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: margin16,
              ),
              widget.data.status.toLowerCase() == 'paid'
                  ? Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: margin8, horizontal: margin16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffDCF9DC).withOpacity(0.5)),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style:
                                      mainBody5.copyWith(color: Colors.black87),
                                  children: [
                                    const TextSpan(text: 'Kamu dapat '),
                                    TextSpan(
                                        text:
                                            '${moneyChanger(widget.data.pointReceived, customLabel: '')} Poin ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(text: 'dari transaksi ini.'),
                                  ])),
                        ),
                        SizedBox(
                          height: margin16,
                        ),
                        BlocBuilder<HostelCubit, HostelState>(
                            bloc: hostelCubit,
                            builder: (context, state) {
                              if (state is HotelLoading) {
                                return PlaceHolder(
                                    child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                ));
                              } else if (state is DetailHostelLoaded) {
                                HostelReview? isAlreadyReview;
                                AuthState stateProfile =
                                    BlocProvider.of<AuthCubit>(context).state;

                                if (stateProfile is AuthLoaded) {
                                  for (var i = 0;
                                      i < state.data.reviews.length;
                                      i++) {
                                    if (state.data.reviews[i].userId ==
                                        stateProfile.data.id) {
                                      isAlreadyReview = state.data.reviews[i];
                                    }
                                  }
                                }

                                if (isAlreadyReview == null) {
                                  return FormHelper.borderButton(context,
                                      onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ReviewHunianPage(
                                                  isHotel: false,
                                                  hunianId:
                                                      widget.data.hostelId,
                                                  roomId: widget.data.room,
                                                )));
                                  }, title: 'Berikan Review');
                                } else {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Review Anda',
                                          style: mainBody4.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            padding: EdgeInsets.all(margin16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: List.generate(5,
                                                          (index) {
                                                        return Icon(
                                                          Icons.star,
                                                          color: index >=
                                                                  isAlreadyReview!
                                                                      .rate
                                                              ? Colors.grey
                                                              : Colors.amber,
                                                        );
                                                      }),
                                                    ),
                                                    Text(
                                                      '${isAlreadyReview.createdAt!.substring(0, 10)} ${isAlreadyReview.createdAt!.substring(11, 16)}',
                                                      style: mainBody5,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: margin4,
                                                ),
                                                Text(
                                                  isAlreadyReview.comment,
                                                  style: mainBody4,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                return FailedRequestHorizontalWidget(
                                  onRetry: () {
                                    hostelCubit.fetchDetailHostel(context,
                                        id: widget.data.hostelId.toString(),
                                        durationType: 'monthly');
                                  },
                                );
                              }
                            })
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        SizedBox(
          height: margin72,
        )
      ],
    );
  }
}
