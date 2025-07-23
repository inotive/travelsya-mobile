import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/profile/vm/profile_edit_vm.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

List<String> options = ['Tuan', 'Nyonya', 'Nona'];

class _ProfileEditPageState extends State<ProfileEditPage> {
  String currentOption = options[0];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileEditVM>.reactive(viewModelBuilder: () {
      return ProfileEditVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return StatusbarWidget(
          child: Scaffold(
              appBar: appbarWidget(context,
                  title: 'Update Profile',
                  customColor: Theme.of(context).primaryColor,
                  customForeground: Colors.white),
              backgroundColor: const Color(0xfff4f4f4),
              body: SingleChildScrollView(
                // padding: EdgeInsets.symmetric(horizontal: margin16),
                child:
                    // SizedBox(
                    //   height: margin24,
                    // ),
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: margin16, vertical: margin24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data Pemilik Akun',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: margin8,
                          ),
                          Wrap(
                            spacing: 8,
                            children: options.map((option) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                    value: option,
                                    groupValue: currentOption,
                                    activeColor: Theme.of(context).primaryColor,
                                    onChanged: (value) {
                                      setState(() {
                                        currentOption = value!;
                                      });
                                    },
                                  ),
                                  Text(option),
                                ],
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: margin8,
                          ),
                          RoundedTextfield(
                            controller: model.nameController,
                            onChanged: (value) {
                              model.onNameChanged(value);
                            },
                            hintText: 'Nama',
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Seperti di KTP/SIM/Paspor',
                            style: secondaryBody5.copyWith(
                              color: neutral30,
                            ),
                          ),
                          SizedBox(
                            height: margin16,
                          ),
                          TitleWithWidget(
                              title: 'Tanggal Lahir',
                              customColor: neutral30,
                              child: RoundedTextfield(
                                onChanged: (value) {},
                                hintText: 'Masukkan Tanggal Lahir',
                                suffixIcon: Icon(
                                  Icons.date_range_outlined,
                                  color: neutral30,
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: margin16, vertical: margin24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Info Kontak',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: margin16,
                          ),
                          TitleWithWidget(
                              title: 'Nomor Handphone',
                              customColor: neutral30,
                              child: RoundedTextfield(
                                onChanged: (value) {},
                                hintText: '81234567890',
                                prefixText: '+62 ',
                              )),
                          SizedBox(
                            height: margin16,
                          ),
                          TitleWithWidget(
                              title: 'Email',
                              validation: model.emailValidation,
                              customColor: neutral30,
                              child: RoundedTextfield(
                                controller: model.emailController,
                                onChanged: (value) {},
                                hintText: 'Masukkan Email',
                              )),
                          Text(
                            'Verifikasi Sekarang',
                            style: secondaryBody5.copyWith(
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: margin16, vertical: margin24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Info Identitas',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: margin16,
                          ),
                          TitleWithWidget(
                              title: 'Detail Kewarganegaraan',
                              customColor: neutral30,
                              child: RoundedTextfield(
                                onChanged: (value) {},
                                hintText: 'Dropdown negara soon',
                              )),
                          SizedBox(
                            height: margin16,
                          ),
                          TitleWithWidget(
                              title: 'NIK',
                              customColor: neutral30,
                              child: RoundedTextfield(
                                onChanged: (value) {},
                                hintText: 'Masukkan NIK',
                              )),
                          Text(
                            'Warga Negara Asing (WNA) boleh memasukkan nomor izin tinggal atau nomor paspor',
                            style: secondaryBody5.copyWith(
                              color: neutral30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: margin16, vertical: margin24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Info Paspor',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: margin16,
                          ),
                          TitleWithWidget(
                              title: 'Nomor Paspor',
                              customColor: neutral30,
                              child: RoundedTextfield(
                                onChanged: (value) {},
                                hintText: 'Masukkan Nomor Paspor',
                              )),
                          SizedBox(
                            height: margin16,
                          ),
                          TitleWithWidget(
                              title: 'Tanggal Penerbitan',
                              customColor: neutral30,
                              child: RoundedTextfield(
                                onChanged: (value) {},
                                hintText: 'dd/mm/yyyy',
                                suffixIcon: Icon(
                                  Icons.date_range_outlined,
                                  color: neutral30,
                                ),
                              )),
                          SizedBox(
                            height: margin16,
                          ),
                          TitleWithWidget(
                              title: 'Tanggal Kadaluarsa',
                              customColor: neutral30,
                              child: RoundedTextfield(
                                onChanged: (value) {},
                                hintText: 'dd/mm/yyyy',
                                suffixIcon: Icon(
                                  Icons.date_range_outlined,
                                  color: neutral30,
                                ),
                              )),
                          Text(
                            'Berlaku setidaknya 6 bulan dari tanggal kepergian.',
                            style: secondaryBody5.copyWith(
                              color: neutral30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: margin16, vertical: margin24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Kontak Darurat',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: margin16,
                          ),
                          RoundedTextfield(
                            onChanged: (value) {},
                            hintText: 'Nama',
                          ),
                          SizedBox(
                            height: margin16,
                          ),
                          TitleWithWidget(
                              title: 'Nomor Handphone',
                              customColor: neutral30,
                              child: RoundedTextfield(
                                onChanged: (value) {},
                                hintText: '81234567890',
                                prefixText: '+62 ',
                              )),
                          SizedBox(
                            height: margin24,
                          ),
                          ElevatedButtonWidget(
                              enabled: true,
                              onTap: () {
                                model.onUpdateSubmit(context);
                              },
                              title: 'Simpan'),
                        ],
                      ),
                    ),
                  ],
                ),

                // Center(
                //   child: GestureDetector(
                //     onTap: () async {
                //       model.onPickPhoto(context);
                //     },
                //     child: Stack(
                //       children: [
                //         BlocBuilder<AuthCubit, AuthState>(
                //             bloc: BlocProvider.of<AuthCubit>(context),
                //             builder: (context, state) {
                //               if (state is AuthLoaded) {
                //                 return model.selectedPhoto == null
                //                     ? state.data.image != null
                //                         ? Container(
                //                             width: 100,
                //                             height: 100,
                //                             decoration: BoxDecoration(
                //                                 shape: BoxShape.circle,
                //                                 color: Colors.white54,
                //                                 image: DecorationImage(
                //                                     fit: BoxFit.cover,
                //                                     image: NetworkImage(
                //                                         '$basePathUserUrl${state.data.image}'))),
                //                           )
                //                         : const Icon(
                //                             Icons.account_circle,
                //                             size: 100,
                //                             color: Colors.grey,
                //                           )
                //                     : Container(
                //                         width: 100,
                //                         height: 100,
                //                         decoration: BoxDecoration(
                //                             shape: BoxShape.circle,
                //                             color: Colors.black12,
                //                             image: DecorationImage(
                //                                 fit: BoxFit.cover,
                //                                 image: FileImage(File(model
                //                                     .selectedPhoto!.path)))),
                //                       );
                //               }

                //               return const Icon(
                //                 Icons.account_circle,
                //                 size: 100,
                //                 color: Colors.grey,
                //               );
                //             }),
                //         Positioned(
                //           bottom: 0,
                //           right: 0,
                //           child: Container(
                //             width: 30,
                //             height: 30,
                //             decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 border:
                //                     Border.all(color: Colors.white, width: 2),
                //                 color: Theme.of(context).primaryColor),
                //             alignment: Alignment.center,
                //             child: const Icon(
                //               Icons.camera_alt,
                //               color: Colors.white,
                //               size: 18,
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: margin24,
                // ),
                // TitleWithWidget(
                //     title: 'Email',
                //     validation: model.emailValidation,
                //     child: Text(
                //       model.emailController.text,
                //       style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                //     )),
                // SizedBox(
                //   height: margin16,
                // ),
                // TitleWithWidget(
                //     title: 'Nama',
                //     validation: model.nameValidation,
                //     child: RoundedTextfield(
                //       controller: model.nameController,
                //       onChanged: (value) {
                //         model.onNameChanged(value);
                //       },
                //       hintText: 'Nama',
                //     )),
                // SizedBox(
                //   height: margin16,
                // ),
                // TitleWithWidget(
                //     title: 'Nomor Handphone',
                //     validation: model.phoneValidation,
                //     child: RoundedTextfield(
                //       controller: model.phoneController,
                //       onChanged: (value) {
                //         model.onPhoneChanged(value);
                //       },
                //       hintText: 'Nomor Handphone',
                //     )),
                // SizedBox(
                //   height: margin32,
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: margin16),
                //   child: ElevatedButtonWidget(
                //       enabled: true,
                //       onTap: () {
                //         model.onUpdateSubmit(context);
                //       },
                //       title: 'Simpan'),
                // ),
                // SizedBox(height: margin32),
              )));
    });
  }
}
