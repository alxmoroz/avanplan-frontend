// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
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
        controller: _controller.teControllers[code],
        label: _controller.tfAnnoForCode(code).label,
        error: _controller.tfAnnoForCode(code).errorText,
        obscureText: code == 'password',
        maxLines: 1,
        capitalization: TextCapitalization.none,
      );

  // TODO: перенести в спец. средство
  // Widget text(BaseText t) {
  //   final style = t.style(context);
  //   return Text(
  //     '${t.text}: ${((style.fontWeight?.index ?? 0) + 1) * 100} | ${style.color?.red} | ${style.fontSize?.round()}',
  //     style: style,
  //   );
  // }
  //
  // Widget testFonts() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //       text(const H1('H1')),
  //       text(const H2('H2')),
  //       text(const H3('H3')),
  //       text(const H4('H4')),
  //       text(const MediumText('MD')),
  //       text(const NormalText('NR')),
  //       text(const LightText('LT')),
  //       text(const SmallText('SM')),
  //     ]);

  @override
  Widget build(BuildContext context) {
    return MTPage(
      isLoading: _controller.isLoading,
      body: Observer(
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // testFonts(),
            H1(loc.appTitle),
            textFieldForCode('login'),
            textFieldForCode('password'),
            SizedBox(height: onePadding),
            Padding(
              padding: EdgeInsets.all(onePadding),
              child: MTButton(
                loc.auth_log_in_btn_title,
                _controller.validated ? _controller.authorize : null,
                titleColor: _controller.validated ? mainColor : borderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
