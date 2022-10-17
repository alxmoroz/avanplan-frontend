// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../login/login_controller.dart';

class LoginView extends StatefulWidget {
  static String get routeName => 'login';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginController _controller;

  @override
  void initState() {
    _controller = LoginController();
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
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                // testFonts(),
                H1(loc.app_title, align: TextAlign.center),
                textFieldForCode('login'),
                textFieldForCode('password'),
                MTButton.outlined(
                  margin: EdgeInsets.symmetric(horizontal: onePadding * 4).copyWith(top: onePadding * 2),
                  padding: EdgeInsets.all(onePadding),
                  titleString: loc.auth_log_in_btn_title,
                  onTap: _controller.validated ? () => _controller.authorize(context) : null,
                ),
                MTButton.outlined(
                  margin: EdgeInsets.symmetric(horizontal: onePadding * 4).copyWith(top: onePadding * 2),
                  padding: EdgeInsets.symmetric(horizontal: onePadding),
                  leading: googleIcon(size: onePadding * 3.7),
                  // titleColor: CupertinoColors.label,
                  middle: MediumText(loc.auth_log_in_with_google_btn_title, padding: EdgeInsets.only(left: onePadding), color: CupertinoColors.label),
                  color: googleBtnColor,
                  onTap: () => _controller.authorizeWithGoogle(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
