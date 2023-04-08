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
import 'sign_in_header.dart';
import 'sign_in_with_password_form.dart';

class SignInView extends StatelessWidget {
  static String get routeName => 'sign-in';

  Widget _signInBtn(Widget leading, String titleText, VoidCallback? onTap) => MTButton.outlined(
        margin: const EdgeInsets.symmetric(horizontal: P_2),
        leading: leading,
        middle: H4(titleText, color: const Color.fromARGB(255, 62, 62, 82)),
        trailing: const SizedBox(width: MIN_BTN_HEIGHT / 2),
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
            constraints: const BoxConstraints(maxWidth: SCR_S_WIDTH),
            child: LayoutBuilder(
              builder: (_, size) => ListView(
                shrinkWrap: true,
                children: [
                  SignInHeader(size),
                  Observer(
                    builder: (_) => Row(
                      children: [
                        Expanded(
                          child: _signInBtn(
                            googleIcon(size: MIN_BTN_HEIGHT),
                            loc.auth_sign_in_with_google_btn_title,
                            () => authController.signInWithGoogle(context),
                          ),
                        ),
                        // для Андроида не показываем SignInWithApple
                        if (authController.signInWithAppleIsAvailable && !isAndroid)
                          Expanded(
                            child: _signInBtn(
                              appleIcon(size: MIN_BTN_HEIGHT),
                              loc.auth_sign_in_with_apple_btn_title,
                              () => authController.signInWithApple(context),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: P2),
                  MTButton(
                    titleText: loc.auth_show_sign_in_form_action_title,
                    trailing: const ChevronIcon(),
                    onTap: () => showSignInPasswordDialog(context),
                  ),
                  const SizedBox(height: P * 5),
                  const LegalLinks(),
                  const SizedBox(height: P2),
                  const AppVersion()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
