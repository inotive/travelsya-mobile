import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/viewmodel/login_vm.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

part '_login_page_form_section.dart';
part '_login_action_section.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginVM>.reactive(viewModelBuilder: () {
      return LoginVM();
    }, onViewModelReady: (model) {
      model.onInit();
    }, builder: (context, model, child) {
      return StatusbarWidget(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Container(
              padding: EdgeInsets.all(margin16),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffFFEEF1)),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Expanded(
                child: _LoginPageFormSection(
              model: model,
            )),
            _LoginActionSection(
              model: model,
            )
          ],
        ),
      ));
    });
  }
}
