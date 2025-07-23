import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
// import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/helper/const_helper.dart';

class HomeProfilePictureWidget extends StatelessWidget {
  final Function onProfileTap;
  const HomeProfilePictureWidget({super.key, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        bloc: BlocProvider.of<AuthCubit>(context),
        builder: (context, state) {
          if (state is AuthLoaded) {
            if (state.data.image != null) {
              return GestureDetector(
                onTap: () {
                  onProfileTap();
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white54,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          // NetworkImage('$basePathUserUrl${state.data.image}'),
                          NetworkImage('${state.data.image}'),
                    ),
                  ),
                ),
              );
            }
          }

          return GestureDetector(
            onTap: () {
              onProfileTap();
            },
            child: SizedBox(
              width: 45,
              height: 45,
              child: Image.asset(ConstHelper.avatarIcon),
            ),
          );
        });
  }
}
