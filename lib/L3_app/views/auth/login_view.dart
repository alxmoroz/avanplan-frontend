// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/text_field.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'login_controller.dart';

class LoginView extends StatefulWidget {
  static String get routeName => 'login';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController get _controller => loginController;

  @override
  void initState() {
    _controller.initState(tfaList: [
      TFAnnotation('login', label: loc.auth_user_placeholder),
      TFAnnotation('password', label: loc.auth_password_placeholder),
    ]);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(String code) => MTTextField(
        controller: _controller.controllers[code],
        label: _controller.tfAnnoForCode(code).label,
        error: _controller.tfAnnoForCode(code).errorText,
        obscureText: code == 'password',
        maxLines: 1,
        capitalization: TextCapitalization.none,
      );

  // TODO: LOADING

  @override
  Widget build(BuildContext context) {
    return MTCupertinoPage(
      body: Observer(
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            H1(loc.appTitle, align: TextAlign.center),
            textFieldForCode('login'),
            textFieldForCode('password'),
            SizedBox(height: onePadding),
            Padding(
              padding: EdgeInsets.all(onePadding),
              child: Button(
                loc.auth_log_in_button_title,
                _controller.validated ? () => _controller.authorize(context) : null,
                titleColor: _controller.validated ? mainColor : borderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
