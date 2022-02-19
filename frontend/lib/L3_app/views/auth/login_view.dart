// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_field.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../base/base_controller.dart';
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
    _controller.initState(context, tfaList: [
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

  Widget textFieldForCode(String code) => CTextField(
        controller: _controller.controllers[code],
        label: _controller.tfAnnoForCode(code).label,
        error: _controller.tfAnnoForCode(code).errorText,
        obscureText: code == 'password',
        maxLines: 1,
        capitalization: TextCapitalization.none,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: backgroundColor.resolve(context),
        child: Observer(
          builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              H1('Hercules', align: TextAlign.center, color: darkGreyColor),
              textFieldForCode('login'),
              textFieldForCode('password'),
              SizedBox(height: onePadding),
              Padding(
                padding: EdgeInsets.all(onePadding),
                child: Button(
                  loc.auth_log_in_button_title,
                  _controller.validated ? _controller.authorize : null,
                  titleColor: _controller.validated ? mainColor : borderColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
