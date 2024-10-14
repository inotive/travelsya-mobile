import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelsya/app/profile/pages/photo_source_picker.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:stacked/stacked.dart';
import 'package:string_validator/string_validator.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/auth/repository/auth_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

class ProfileEditVM extends BaseViewModel {
  XFile? selectedPhoto;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? nameValidation;
  String? phoneValidation;
  String? emailValidation;

  onPickPhoto(BuildContext context) async {
    int? result = await showDialog(
        context: context,
        builder: (context) {
          return const PhotoSourcePickerDialog();
        });

    if (result != null) {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(
          source: result == 0 ? ImageSource.gallery : ImageSource.camera);

      if (image != null) {
        selectedPhoto = image;
        notifyListeners();
      }
    }
  }

  onEmailChanged(String value) {
    if (value.isEmpty) {
      emailValidation = 'Mohon mengisi email Anda';
    } else {
      if (isEmail(value)) {
        emailValidation = null;
      } else {
        emailValidation = 'Email tidak valid';
      }
    }

    notifyListeners();
  }

  onNameChanged(String value) {
    if (value.isEmpty) {
      nameValidation = 'Mohon mengisi nama Anda';
    } else {
      if (isAlpha(value.replaceAll(' ', ''))) {
        nameValidation = null;
      } else {
        nameValidation =
            'Nama tidak valid, mohon mengisi nama hanya dengan karakter alphabet';
      }
    }
    notifyListeners();
  }

  onPhoneChanged(String value) {
    if (value.length < 6) {
      phoneValidation = 'Mohon mengisi nomor handphone Anda';
    } else {
      if (isNumeric(value)) {
        phoneValidation = null;
      } else {
        phoneValidation = 'Nomor Handphone Tidak Valid';
      }
    }
    notifyListeners();
  }

  onInit(BuildContext context) {
    AuthState state = BlocProvider.of<AuthCubit>(context).state;
    if (state is AuthLoaded) {
      nameController.text = state.data.name;
      phoneController.text = state.data.phone ?? '';
      emailController.text = state.data.email;
    }
  }

  onUpdateSubmit(BuildContext context) async {
    onEmailChanged(emailController.text);
    onPhoneChanged(phoneController.text);
    onNameChanged(nameController.text);

    if (emailValidation == null &&
        phoneValidation == null &&
        nameValidation == null) {
      AuthState state = BlocProvider.of<AuthCubit>(context).state;
      if (state is AuthLoaded) {
        bool isSuccessPhoto = false;
        if (selectedPhoto != null) {
          showLoading(context);

          ApiReturnValue uploadResult =
              await AuthRepository.updateProfilePicture(context,
                  file: File(selectedPhoto!.path));

          if (context.mounted) {
            Navigator.pop(context);

            if (uploadResult.status == RequestStatus.successRequest) {
              isSuccessPhoto = true;
            }
          }
        } else {
          isSuccessPhoto = true;
        }

        if (isSuccessPhoto && context.mounted) {
          showLoading(context);
          AuthRepository.updateProfile(context,
                  email: emailController.text,
                  name: nameController.text,
                  phone: phoneController.text,
                  data: state.data)
              .then((value) {
            Navigator.pop(context);
            if (value.status == RequestStatus.successRequest) {
              BlocProvider.of<AuthCubit>(context).updateData(value.data);
              showSnackbar(context,
                  data: 'Berhasil menyimpan data profile',
                  colors: Colors.green);
              Navigator.pop(context);
            } else {
              showSnackbar(context,
                  data: value.data ?? 'Gagal menyimpan data profile',
                  colors: Colors.orange);
            }
          });
        } else {
          if (context.mounted) {
            showSnackbar(context,
                data: 'Gagal menyimpan foto profile', colors: Colors.orange);
          }
        }
      }
    } else {
      showSnackbar(context,
          data: 'Mohon mengisi form dengan benar', colors: Colors.orange);
    }
  }
}
