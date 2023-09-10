// Copyright (c) 2022. Alexandr Moroz

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'L3_app/components/colors.dart';
import 'L3_app/components/colors_base.dart';
import 'L3_app/extra/navigator.dart';
import 'L3_app/extra/services.dart';
import 'L3_app/l10n/generated/l10n.dart';
import 'L3_app/views/auth/auth_view.dart';
import 'L3_app/views/loader/loader_screen.dart';
import 'L3_app/views/main/main_view.dart';

Future main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();

  // certs
  if (!kIsWeb) {
    final ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  usePathUrlStrategy();
  runApp(App());
}

final rootKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cupertinoTextTheme = CupertinoTheme.of(context).textTheme;

    // const fontFamily = '--apple-system';
    const fontFamily = 'Roboto';

    const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate
    ];

    final supportedLocales = S.delegate.supportedLocales;
    final cupertinoTheme = CupertinoThemeData(
      scaffoldBackgroundColor: b2Color,
      primaryColor: mainColor,
      textTheme: cupertinoTextTheme.copyWith(
        primaryColor: mainColor,
        textStyle: cupertinoTextTheme.textStyle.copyWith(fontFamily: fontFamily),
      ),
    );

    const _DEBUG_BANNER = true;

    return MaterialApp(
      debugShowCheckedModeBanner: _DEBUG_BANNER,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: mainColor.resolve(context),
          brightness: View.of(context).platformDispatcher.platformBrightness,
          background: b2Color.resolve(context),
          surfaceTint: b2Color.resolve(context),
          surface: b3Color.resolve(context),
        ),
        fontFamily: fontFamily,
        useMaterial3: true,
      ),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      onGenerateRoute: (RouteSettings rs) {
        deepLinkController.parseDeepLink(rs.name);
        return null;
      },
      home: Observer(
        builder: (_) => Stack(children: [
          CupertinoApp(
            debugShowCheckedModeBanner: _DEBUG_BANNER,
            navigatorKey: rootKey,
            home: FutureBuilder(
              future: getIt.allReady(),
              builder: (_, snapshot) =>
                  snapshot.hasData ? Observer(builder: (_) => authController.authorized ? MainView() : AuthView()) : Container(),
            ),
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            theme: cupertinoTheme,
            title: loc.app_title,
            onGenerateRoute: cupertinoPageRoute,
            navigatorObservers: [MTRouteObserver()],
          ),
          if (loader.loading)
            CupertinoApp(
              debugShowCheckedModeBanner: _DEBUG_BANNER,
              home: LoaderScreen(),
              localizationsDelegates: localizationsDelegates,
              supportedLocales: supportedLocales,
              theme: cupertinoTheme,
              title: loc.app_title,
            )
        ]),
      ),
    );
  }
}
