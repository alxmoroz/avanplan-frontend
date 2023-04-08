// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../settings/app_version.dart';
import 'legal_links.dart';
import 'sign_in_email_form.dart';
import 'sign_in_header.dart';

class SignInView extends StatelessWidget {
  static String get routeName => 'sign-in';

  Widget _signInBtn(Widget leading, String titleText, double iconSize, VoidCallback? onTap, {double? titleLeftPadding}) => MTButton.outlined(
        leading: leading,
        middle: H4(titleText, color: const Color.fromARGB(255, 62, 62, 82), padding: EdgeInsets.only(left: titleLeftPadding ?? 0)),
        trailing: SizedBox(width: iconSize / 2),
        color: const Color(0xFFFFFFFF),
        titleColor: greyColor,
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return MTPage(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: SCR_S_WIDTH * 0.8),
            child: LayoutBuilder(
              builder: (_, size) => ListView(
                shrinkWrap: true,
                children: [
                  SignInHeader(size),
                  H4(loc.auth_sign_in_title, align: TextAlign.center, color: greyColor),
                  const SizedBox(height: P2),
                  Observer(
                    builder: (_) => Column(
                      children: [
                        _signInBtn(
                          googleIcon(size: MIN_BTN_HEIGHT),
                          loc.auth_sign_in_google_btn_title,
                          MIN_BTN_HEIGHT,
                          () => authController.signInGoogle(context),
                        ),
                        // для Андроида не показываем SignInWithApple
                        if (authController.signInWithAppleIsAvailable && !isAndroid) ...[
                          const SizedBox(height: P),
                          _signInBtn(
                            appleIcon(size: MIN_BTN_HEIGHT),
                            loc.auth_sign_in_apple_btn_title,
                            MIN_BTN_HEIGHT,
                            () => authController.signInApple(context),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: P),
                  _signInBtn(
                    const MailIcon(color: Color.fromARGB(255, 62, 62, 82)),
                    loc.auth_sign_in_mail_btn_title,
                    P2,
                    () => showSignInEmailDialog(context),
                    titleLeftPadding: P,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          LegalLinks(),
          SizedBox(height: P_2),
          AppVersion(),
        ],
      ),
    );
  }
}
