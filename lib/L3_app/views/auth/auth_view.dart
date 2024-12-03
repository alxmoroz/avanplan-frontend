// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/divider.dart';
import '../../components/icons.dart';
import '../../components/images.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../navigation/route.dart';
import '../../usecases/communications.dart';
import '../_base/loader_screen.dart';
import '../app/about_dialog.dart';
import '../app/app_title.dart';
import 'auth_extra_dialog.dart';

final authRoute = MTRoute(
  baseName: 'auth',
  path: '/auth',
  noTransition: true,
  builder: (_, state) => _AuthView(key: state.pageKey),
);

class _AuthView extends StatefulWidget {
  const _AuthView({super.key});

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

  Widget _authBtn(Widget icon, VoidCallback? onTap) => MTButton(
        type: MTButtonType.card,
        minSize: const Size.square(P12),
        margin: const EdgeInsets.symmetric(horizontal: P + P_2),
        constrained: false,
        middle: icon,
        color: bwColor,
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => appController.loading
          ? LoaderScreen(appController)
          : authController.loading
              ? LoaderScreen(authController)
              : MTPage(
                  key: widget.key,
                  navBar: MTTopBar(
                    leading: const SizedBox(),
                    middle: const AppTitle(),
                    color: isBigScreen(context) ? Colors.transparent : navbarColor,
                  ),
                  body: SafeArea(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // ColorsDemo(),
                            // TextDemo(),
                            MTImage(ImageName.hello.name, height: 300),
                            const SizedBox(height: P2),
                            BaseText.medium(
                              loc.auth_sign_in_with_title,
                              align: TextAlign.center,
                              color: f2Color,
                              padding: const EdgeInsets.all(P3),
                            ),
                            MTAdaptive.xs(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _authBtn(googleIcon, authController.signInGoogle),
                                  // для Андроида не показываем SignInWithApple
                                  if (authController.signInWithAppleIsAvailable && !isAndroid)
                                    _authBtn(const MTImage('apple_icon', height: P6, width: P6), authController.signInApple),
                                  _authBtn(yandexIcon, authController.signInYandex),
                                  const MTButton(
                                    type: MTButtonType.card,
                                    constrained: false,
                                    minSize: Size.square(P12),
                                    middle: MenuHorizontalIcon(size: P6),
                                    margin: EdgeInsets.symmetric(horizontal: P + P_2),
                                    color: bwColor,
                                    onTap: authExtraDialog,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: P4),
                            MTButton(
                              leading: SmallText('${loc.auth_help_title}?'),
                              middle: SmallText.medium(loc.action_email_support_title, color: mainColor),
                              onTap: () => mailUs(subject: loc.auth_help_title),
                            ),
                            const SizedBox(height: P4),
                          ],
                        ),
                      ),
                    ),
                  ),
                  bottomBar: MTBottomBar(
                    topPadding: 0,
                    innerHeight: P6,
                    middle: Column(children: [
                      const MTAdaptive.xs(child: MTDivider(indent: P3, endIndent: P3)),
                      const SizedBox(height: P2),
                      MTButton(
                        middle: SmallText.medium(loc.about_service_title, color: mainColor),
                        onTap: showAboutServiceDialog,
                      ),
                    ]),
                  ),
                ),
    );
  }
}
