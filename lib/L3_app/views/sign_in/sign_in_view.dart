// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../L2_data/repositories/platform.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'sign_in_terms_links.dart';
import 'sign_in_with_password_form.dart';

class SignInView extends StatelessWidget {
  static String get routeName => 'sign-in';

  @override
  Widget build(BuildContext context) {
    return MTPage(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: SCR_S_WIDTH),
            child: LayoutBuilder(
              builder: (_, size) => Observer(
                builder: (_) => ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: size.maxHeight / 5, child: FittedBox(child: gerculesIcon())),
                    //
                    H1(loc.app_title, align: TextAlign.center, padding: const EdgeInsets.symmetric(vertical: P)),

                    MTButton.outlined(
                      margin: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
                      leading: googleIcon(size: MIN_BTN_HEIGHT),
                      middle: MediumText(loc.auth_sign_in_with_google_btn_title, color: CupertinoColors.label),
                      color: googleBtnColor,
                      onTap: () => authController.signInWithGoogle(context),
                    ),
                    // для Андроида не показываем SignInWithApple
                    if (!isAndroid && authController.signInWithAppleIsAvailable)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P),
                        child: SignInWithAppleButton(
                          height: MIN_BTN_HEIGHT,
                          text: loc.auth_sign_in_with_apple_btn_title,
                          borderRadius: const BorderRadius.all(Radius.circular(DEF_BORDER_RADIUS)),
                          style: MediaQuery.of(context).platformBrightness == Brightness.dark
                              ? SignInWithAppleButtonStyle.white
                              : SignInWithAppleButtonStyle.black,
                          onPressed: () => authController.signInWithApple(context),
                        ),
                      ),
                    MTButton.outlined(
                      margin: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
                      titleText: loc.auth_show_sign_in_form_action_title,
                      onTap: () => showSignInPasswordDialog(context),
                    ),
                    const SizedBox(height: P * 3),
                    const SignInTermsLinks(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
