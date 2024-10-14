part of 'login_page.dart';

class _LoginPageFormSection extends StatelessWidget {
  final LoginVM model;
  const _LoginPageFormSection({required this.model});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: margin32,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: margin16),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Masuk ke Travelsya',
                    style: mainBody1.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: margin32,
                ),
                TitleWithWidget(
                    title: 'Email',
                    validation: model.emailValidation,
                    child: RoundedTextfield(
                        hintText: 'Masukkan email Anda',
                        controller: model.emailController,
                        onChanged: (value) {
                          model.onEmailChanged(value);
                        })),
                SizedBox(
                  height: margin16,
                ),
                TitleWithWidget(
                    title: 'Kata Sandi',
                    validation: model.passwordValidation,
                    child: RoundedTextfield(
                        hintText: 'Masukkan kata sandi Anda',
                        suffixWidget: GestureDetector(
                            onTap: () {
                              model.onPasswordIconTap();
                            },
                            child: Icon(
                                model.isPasswordShow
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: model.isPasswordShow
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey)),
                        obscureText: !model.isPasswordShow,
                        controller: model.passwordController,
                        onChanged: (value) {
                          model.onPasswordChanged(value);
                        })),
                SizedBox(
                  height: margin16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: margin24,
                          height: margin24,
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (value) {
                              model.onRememberMeTap();
                            },
                            value: model.isRememberMe,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        SizedBox(
                          width: margin4,
                        ),
                        Text(
                          'Ingat Saya',
                          style: mainBody5,
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        model.onForgotPasswordTap(context);
                      },
                      child: Text('Lupa kata sandi?',
                          style: mainBody4.copyWith(
                              color: Theme.of(context).primaryColor)),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: margin32,
          ),
        ],
      ),
    );
  }
}
