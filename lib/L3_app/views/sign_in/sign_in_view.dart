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
    return Observer(
      builder: (_) => MTPage(
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                gerculesIcon(size: onePadding * 14),
                H1(loc.app_title, align: TextAlign.center),

                MTButton.outlined(
                  margin: EdgeInsets.symmetric(horizontal: onePadding * 4).copyWith(top: onePadding * 3),
                  leading: googleIcon(size: minButtonHeight),
                  middle: MediumText(loc.auth_sign_in_with_google_btn_title, color: CupertinoColors.label),
                  color: googleBtnColor,
                  onTap: () => authController.signInWithGoogle(context),
                ),
                // для Андроида не показываем SignInWithApple
                if (!isAndroid && authController.signInWithAppleIsAvailable)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: onePadding * 4).copyWith(top: onePadding * 1),
                    child: SignInWithAppleButton(
                      height: minButtonHeight,
                      text: loc.auth_sign_in_with_apple_btn_title,
                      borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
                      style: MediaQuery.of(context).platformBrightness == Brightness.dark
                          ? SignInWithAppleButtonStyle.white
                          : SignInWithAppleButtonStyle.black,
                      onPressed: () => authController.signInWithApple(context),
                    ),
                  ),
                MTButton.outlined(
                  margin: EdgeInsets.symmetric(horizontal: onePadding * 4).copyWith(top: onePadding * 1),
                  titleText: loc.auth_show_sign_in_form_action_title,
                  onTap: () => showSignInPasswordDialog(context),
                ),
                SizedBox(height: onePadding * 3),
                const SignInTermsLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
