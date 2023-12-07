import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hostel/repository/hostel_repository.dart';
import 'package:travelsya/app/hotel/repository/hotel_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

class HunianReviewVM extends BaseViewModel {
  double rating = 5;

  TextEditingController reviewController = TextEditingController();

  onChangeRating(double value) {
    rating = value;
    notifyListeners();
  }

  onSubmit(
    BuildContext context, {
    required bool isHotel,
    required String id,
    required String roomId,
  }) {
    if (reviewController.text.isEmpty) {
      showSnackbar(context,
          data: 'Mohon mengisi review Anda', colors: Colors.orange);
    } else {
      showLoading(context);
      if (isHotel) {
        HotelRepository.ratingHotel(context,
                hotelId: id,
                roomId: roomId,
                review: reviewController.text,
                star: rating.toStringAsFixed(0))
            .then((value) {
          Navigator.pop(context);
          if (value.status == RequestStatus.successRequest) {
            Navigator.pop(context);
            showSnackbar(context,
                data: 'Berhasil memberikan ulasan', colors: Colors.green);
          } else {
            showSnackbar(context,
                data: 'Gagal memberikan ulasan, silahkan coba lagi',
                colors: Colors.orange);
          }
        });
      } else {
        HostelRepository.ratingHostel(context,
                hostelId: id,
                roomId: roomId,
                review: reviewController.text,
                star: rating.toStringAsFixed(0))
            .then((value) {
          Navigator.pop(context);
          if (value.status == RequestStatus.successRequest) {
            Navigator.pop(context);
            showSnackbar(context,
                data: 'Berhasil memberikan ulasan', colors: Colors.green);
          } else {
            showSnackbar(context,
                data: 'Gagal memberikan ulasan, silahkan coba lagi',
                colors: Colors.orange);
          }
        });
      }
    }
  }

  String getReviewVal(double data) {
    double reviewVal = data;

    if (reviewVal <= 1) {
      return 'Buruk';
    } else if (reviewVal <= 2) {
      return 'Kurang Baik';
    } else if (reviewVal <= 3) {
      return 'Cukup';
    } else if (reviewVal <= 4) {
      return 'Baik';
    } else if (reviewVal <= 5) {
      return 'Sangat Baik';
    } else {
      return '';
    }
  }
}
