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
import 'registration_form.dart';
import 'sign_in_email_form.dart';

class AuthView extends StatefulWidget {
  static String get routeName => 'auth';

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with WidgetsBindingObserver {
  void _startupActions() => WidgetsBinding.instance.addPostFrameCallback((_) async => await authController.startupActions());

  @override
  void initState() {
    _startupActions();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startupActions();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  static const Color _greyColor = Color.fromARGB(255, 62, 62, 82);
  static const Color _whiteColor = Color(0xFFFFFFFF);

  Widget _authBtn(
    Widget leading,
    String titleText,
    double iconSize,
    VoidCallback? onTap, {
    double? titleLeftPadding,
  }) =>
      MTButton.main(
        leading: leading,
        middle: H3(titleText, color: _greyColor, padding: EdgeInsets.only(left: titleLeftPadding ?? 0)),
        trailing: SizedBox(width: iconSize / 2),
        color: _whiteColor,
        titleColor: _whiteColor,
        onTap: onTap,
        margin: const EdgeInsets.only(top: P),
      );

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
                    H1(loc.app_title, align: TextAlign.center),
                    const SizedBox(height: P2),
                    appIcon(size: size.maxHeight / 4),
                    H3(authController.registerMode ? loc.auth_register_with_title : loc.auth_sign_in_with_title,
                        align: TextAlign.center, color: greyColor),
                    const SizedBox(height: P),
                    Column(
                      children: [
                        _authBtn(
                          googleIcon,
                          loc.auth_sign_in_google_title,
                          MIN_BTN_HEIGHT,
                          authController.signInGoogle,
                        ),
                        // для Андроида не показываем SignInWithApple
                        if (authController.signInWithAppleIsAvailable && !isAndroid)
                          _authBtn(
                            appleIcon,
                            loc.auth_sign_in_apple_title,
                            MIN_BTN_HEIGHT,
                            authController.signInApple,
                          ),
                      ],
                    ),
                    _authBtn(
                      const MailIcon(color: _greyColor),
                      loc.auth_sign_in_email_title,
                      P2,
                      authController.registerMode ? registrationDialog : showSignInEmailDialog,
                      titleLeftPadding: P,
                    ),
                    const SizedBox(height: P2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NormalText(authController.registerMode ? loc.auth_sign_in_mode_hint_title : loc.auth_register_mode_hint_title),
                        const SizedBox(width: P_2),
                        MTButton(
                          titleText: authController.registerMode ? loc.auth_sign_in_mode_title : loc.auth_register_mode_title,
                          onTap: authController.toggleRegisterMode,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isIOS) const LegalLinks(),
          const AppVersion(),
        ],
      ),
    );
  }
}
