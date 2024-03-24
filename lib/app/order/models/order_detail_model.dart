import 'package:travelsya/app/hostel/models/hostel_detail_model.dart';
import 'package:travelsya/app/hotel/models/hotel_detail_model.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';

class OrderDetailInquiryModel {
  late int id;
  late String noInv;
  late String noPelanggan;
  String? namaPelanggan;
  String? reqId;
  String? link;
  late String service;
  String? payment;
  String? paymentMethod;
  String? paymentChannel;
  late String status;
  late double adminFee;
  late double total;
  late double poinUsed;
  late double poinReceived;
  String? createdAt;

  OrderDetailInquiryModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    noInv = jsonMap['no_inv'];
    noPelanggan = jsonMap['nomor_pelanggan'];
    namaPelanggan = jsonMap['nama_pelanggan'];
    reqId = jsonMap['req_id'];
    link = jsonMap['link'];
    service = jsonMap['service'];
    payment = jsonMap['payment'];
    paymentMethod = jsonMap['payment_method'];
    paymentChannel = jsonMap['payment_channel'];
    status = jsonMap['status'];
    total = double.parse(jsonMap['total'].toString());
    adminFee = double.parse(
        jsonMap['fee_admin'] == null ? '0' : jsonMap['fee_admin'].toString());
    poinReceived = double.parse(jsonMap['point_received'] == null
        ? '0'
        : jsonMap['point_received'].toString());
    poinUsed = double.parse(
        jsonMap['point_used'] == null ? '0' : jsonMap['point_used'].toString());
    createdAt = jsonMap['created_at'];
  }
}

class OrderDetailTopupModel {
  late int id;
  String? noInv;
  late String noPhone;
  String? reqId;
  String? link;
  late String service;
  PPOBModel? product;
  String? payment;
  String? paymentMethod;
  String? voucherCode;
  late String status;
  late double adminFee;
  late double pointReceived;
  String? paymentChannel;
  late double pointUsed;
  late double total;
  String? createdAt;

  OrderDetailTopupModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    noInv = jsonMap['no_inv'];
    noPhone = jsonMap['nomor_telfon'];
    paymentChannel = jsonMap['payment_channel'];
    reqId = jsonMap['req_id'];
    link = jsonMap['link'];
    service = jsonMap['service'];
    for (var i = 0; i < jsonMap['product'].length; i++) {
      product = PPOBModel.fromJson(jsonMap['product'][i]);
    }
    payment = jsonMap['payment'];
    paymentMethod = jsonMap['payment_method'];
    voucherCode = jsonMap['kode_voucher'];
    status = jsonMap['status'];
    adminFee = double.parse(
        jsonMap['fee_admin'] == null ? '0' : jsonMap['fee_admin'].toString());
    total = double.parse(jsonMap['total'].toString());
    pointReceived = double.parse(jsonMap['point_received'] == null
        ? '0'
        : jsonMap['point_received'].toString());
    pointUsed = double.parse(
        jsonMap['point_used'] == null ? '0' : jsonMap['point_used'].toString());
    createdAt = jsonMap['created_at'];
  }
}

class OrderDetailHostelModel {
  late int id;
  late String noInv;
  late int hostelId;
  late int hostelRoomId;
  late String hostelName;
  late String hostelRoomName;
  late String bookinId;
  late String guestName;
  late String guestPhone;
  late String guestEmail;
  late String startDate;
  late String endDate;
  late int guest;
  late int room;
  late String typeRent;
  late String reqId;
  String? link;
  late String service;
  String? paymentMethod;
  String? paymentChannel;
  late String status;
  late double adminFee;
  late double total;
  late double pointUsed;
  late double pointReceived;
  String? createdAt;
  HostelReview? review;

  OrderDetailHostelModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    noInv = jsonMap['no_inv'];
    hostelId = jsonMap['hostel_id'] ?? 3;
    hostelRoomId = jsonMap['hostel_room_id'] ?? 2;
    hostelName = jsonMap['hostel_name'];
    hostelRoomName = jsonMap['hotel_room_name'];
    bookinId = jsonMap['booking_id'];
    guestName = jsonMap['guest_identity'][0]['name'] ?? '';
    guestPhone = jsonMap['guest_identity'][0]['handphone'] ?? '';
    guestEmail = jsonMap['guest_identity'][0]['email'] ?? '';
    startDate = jsonMap['reservation_start'];
    endDate = jsonMap['reservation_end'];
    guest = jsonMap['guest'];
    room = jsonMap['room'];
    typeRent = jsonMap['type_rent'];
    reqId = jsonMap['req_id'];
    link = jsonMap['link'];
    service = jsonMap['service'];
    paymentMethod = jsonMap['payment_method'];
    paymentChannel = jsonMap['payment_channel'];
    status = jsonMap['status'];
    adminFee = double.parse(
        jsonMap['fee_admin'] == null ? '0' : jsonMap['fee_admin'].toString());
    total = double.parse(jsonMap['total'].toString());
    pointReceived = double.parse(jsonMap['point_received'] == null
        ? '0'
        : jsonMap['point_received'].toString());
    pointUsed = double.parse(
        jsonMap['used_point'] == null ? '0' : jsonMap['used_point'].toString());
    createdAt = jsonMap['created_at'];
    try {
      review = jsonMap['review'] == null
          ? null
          : HostelReview.fromJson(jsonMap['review']);
    } catch (e) {
      review = null;
    }
  }
}

class OrderDetailHotelModel {
  late int id;
  late String noInv;
  late int hotelId;
  late int hotelRoomId;
  late String hotelName;
  late String hotelRoomName;
  late String bookinId;
  late String guestName;
  late String guestPhone;
  late String guestEmail;
  late String startDate;
  late String endDate;
  late int guest;
  late int room;
  late String reqId;
  String? link;
  late String service;
  String? paymentMethod;
  String? paymentChannel;
  late String status;
  late double adminFee;
  late double total;
  late double pointUsed;
  late double pointReceived;
  String? createdAt;
  HotelReview? review;

  OrderDetailHotelModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    noInv = jsonMap['no_inv'];
    hotelId = jsonMap['hotel_id'];
    hotelRoomId = jsonMap['hotel_room_id'];
    hotelName = jsonMap['hotel_name'];
    hotelRoomName = jsonMap['hotel_room_name'];
    bookinId = jsonMap['booking_id'];
    guestName = jsonMap['guest_identity'][0]['name'] ?? '';
    guestPhone = jsonMap['guest_identity'][0]['handphone'] ?? '';
    guestEmail = jsonMap['guest_identity'][0]['email'] ?? '';
    startDate = jsonMap['reservation_start'];
    endDate = jsonMap['reservation_end'];
    guest = jsonMap['guest'];
    room = jsonMap['room'];
    reqId = jsonMap['req_id'];
    link = jsonMap['link'];
    service = jsonMap['service'];
    paymentMethod = jsonMap['payment_method'];
    paymentChannel = jsonMap['payment_channel'];
    status = jsonMap['status'];
    adminFee = double.parse(
        jsonMap['fee_admin'] == null ? '0' : jsonMap['fee_admin'].toString());
    total = double.parse(jsonMap['total'].toString());
    pointReceived = double.parse(jsonMap['point_received'] == null
        ? '0'
        : jsonMap['point_received'].toString());
    pointUsed = double.parse(
        jsonMap['used_point'] == null ? '0' : jsonMap['used_point'].toString());
    createdAt = jsonMap['created_at'];
    try {
      review = jsonMap['review_hotel'] == null
          ? null
          : HotelReview.fromJson(jsonMap['review_hotel']);
    } catch (e) {
      review = null;
    }
  }
}
