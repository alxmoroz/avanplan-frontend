// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/images.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../main/widgets/app_title.dart';
import '../settings/app_version.dart';
import 'legal_links.dart';
import 'registration_form.dart';
import 'sign_in_email_form.dart';

class AuthView extends StatefulWidget {
  static String get routeName => '/auth';

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

  static final Color _titleColor = f1Color.color;
  static const Color _btnColor = Color(0xFFFFFFFF);

  Widget _authBtn(
    Widget leading,
    String titleText,
    double iconSize,
    VoidCallback? onTap, {
    double? titleLeftPadding,
  }) =>
      MTButton.main(
        leading: leading,
        middle: H3(titleText, color: _titleColor, padding: EdgeInsets.only(left: titleLeftPadding ?? 0)),
        trailing: SizedBox(width: iconSize / 2),
        color: _btnColor,
        titleColor: _btnColor,
        onTap: onTap,
        margin: const EdgeInsets.only(top: P3),
      );

  @override
  Widget build(BuildContext context) {
    return MTPage(
      appBar: MTAppBar(context, middle: AppTitle()),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: SCR_XS_WIDTH),
            child: LayoutBuilder(
              builder: (_, size) => Observer(
                builder: (_) => ListView(
                  shrinkWrap: true,
                  children: [
                    // ColorsDemo(),
                    // TextDemo(),
                    MTImage(ImageName.hello.name),
                    H3(
                      authController.registerMode ? loc.register_with_title : loc.auth_sign_in_with_title,
                      align: TextAlign.center,
                      padding: const EdgeInsets.only(top: P3),
                    ),
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
                      MailIcon(color: _titleColor, size: P4),
                      loc.auth_sign_in_email_title,
                      P4,
                      authController.registerMode ? registrationDialog : showSignInEmailDialog,
                      titleLeftPadding: P2,
                    ),
                    const SizedBox(height: P3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseText(authController.registerMode ? loc.auth_sign_in_mode_hint_title : ''),
                        const SizedBox(width: P),
                        MTButton(
                          titleText: authController.registerMode ? loc.auth_sign_in_mode_title : loc.register_mode_title,
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
          if (!isIOS) ...[
            const LegalLinks(),
            const SizedBox(height: P2),
          ],
          const AppVersion(),
        ],
      ),
    );
  }
}
