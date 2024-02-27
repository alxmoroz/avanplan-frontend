// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/divider.dart';
import '../../components/icons.dart';
import '../../components/images.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../usecases/communications.dart';
import '../app/about_dialog.dart';
import '../app/app_title.dart';
import 'auth_extra_dialog.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  static String get routeName => '/auth';

  @override
  State<StatefulWidget> createState() => _AuthViewState();
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
        margin: const EdgeInsets.only(top: P2),
      );

  @override
  Widget build(BuildContext context) {
    return MTPage(
      appBar: MTAppBar(leading: const SizedBox(), middle: const AppTitle(), color: isBigScreen(context) ? Colors.transparent : null),
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              // ColorsDemo(),
              // TextDemo(),
              MTImage(ImageName.hello.name),
              H3(
                loc.auth_sign_in_with_title,
                align: TextAlign.center,
                padding: const EdgeInsets.only(top: P2),
              ),
              _authBtn(
                googleIcon,
                loc.auth_sign_in_google_title,
                MIN_BTN_HEIGHT - 2,
                authController.signInGoogle,
              ),
              // для Андроида не показываем SignInWithApple
              if (authController.signInWithAppleIsAvailable && !isAndroid)
                _authBtn(
                  appleIcon,
                  loc.auth_sign_in_apple_title,
                  MIN_BTN_HEIGHT - 2,
                  authController.signInApple,
                ),
              MTButton.main(
                middle: BaseText.medium(loc.auth_sign_in_extra_title, color: _titleColor),
                color: b3Color.color,
                // titleColor: _btnColor,
                margin: const EdgeInsets.only(top: P2),
                onTap: authExtraDialog,
              ),
              const SizedBox(height: P3),
              MTButton(
                titleText: '${loc.auth_help_title}? ${loc.contact_us_title}',
                onTap: () => mailUs(subject: loc.auth_help_title),
              ),
              const MTAdaptive.xs(child: MTDivider(indent: P2, endIndent: P2, verticalIndent: P4)),
              MTButton(titleText: loc.about_service_title, onTap: showAboutServiceDialog),
            ],
          ),
        ),
      ),
    );
  }
}
