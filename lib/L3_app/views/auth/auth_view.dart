// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/divider.dart';
import '../../components/icons.dart';
import '../../components/images.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/route.dart';
import '../../extra/services.dart';
import '../../usecases/communications.dart';
import '../_base/loader_screen.dart';
import '../app/about_dialog.dart';
import '../app/app_title.dart';
import 'auth_extra_dialog.dart';

final authRoute = MTRoute(
  baseName: 'auth',
  path: '/auth',
  noTransition: true,
  builder: (_, __) => const _AuthView(),
);

class _AuthView extends StatefulWidget {
  const _AuthView();

  @override
  State<StatefulWidget> createState() => _AuthViewState();
}

class _AuthViewState extends State<_AuthView> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    authController.startup();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      authController.startup();
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
      MTButton(
        type: ButtonType.main,
        constrained: true,
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
    return Observer(
      builder: (_) => appController.loading
          ? LoaderScreen(appController)
          : authController.loading
              ? LoaderScreen(authController)
              : MTPage(
                  appBar: MTAppBar(leading: const SizedBox(), middle: const AppTitle(), color: isBigScreen(context) ? Colors.transparent : null),
                  body: SafeArea(
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          // ColorsDemo(),
                          // TextDemo(),
                          MTImage(ImageName.hello.name),
                          BaseText(
                            loc.auth_sign_in_with_title,
                            align: TextAlign.center,
                            padding: const EdgeInsets.only(top: P2),
                          ),
                          const SizedBox(height: P),
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
                          MTButton(
                            type: ButtonType.main,
                            constrained: true,
                            middle: BaseText.medium(loc.auth_sign_in_extra_title, color: _titleColor),
                            color: b3Color.color,
                            margin: const EdgeInsets.only(top: P2),
                            onTap: authExtraDialog,
                          ),
                          const SizedBox(height: P4),
                          MTButton(
                            middle: SmallText('${loc.auth_help_title}? ${loc.contact_us_title}', color: mainColor),
                            onTap: () => mailUs(subject: loc.auth_help_title),
                          ),
                          const MTAdaptive.xs(child: MTDivider(indent: P3, endIndent: P3, verticalIndent: P2)),
                          MTButton(
                            middle: SmallText(loc.about_service_title, color: mainColor),
                            onTap: showAboutServiceDialog,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
