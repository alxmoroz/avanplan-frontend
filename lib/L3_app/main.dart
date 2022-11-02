// Copyright (c) 2022. Alexandr Moroz

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'components/colors.dart';
import 'extra/loader/loader_screen.dart';
import 'extra/services.dart';
import 'l10n/generated/l10n.dart';
import 'views/account/account_view.dart';
import 'views/login/login_view.dart';
import 'views/main/main_view.dart';
import 'views/settings/settings_view.dart';
import 'views/source/source_list_view.dart';
import 'views/task/task_view.dart';
import 'views/workspace/workspace_list_view.dart';

Future main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();

  // certs
  if (!kIsWeb) {
    final ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  runApp(App());
}

final navigatorKey = GlobalKey<NavigatorState>();

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

    return MaterialApp(
      theme: ThemeData(
        // brightness: WidgetsBinding.instance.window.platformBrightness,
        // colorSchemeSeed: mainColor.resolve(context),
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor.resolve(context), brightness: WidgetsBinding.instance.window.platformBrightness),
        fontFamily: fontFamily,
        useMaterial3: true,
      ),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      home: Observer(
        builder: (_) => Stack(children: [
          CupertinoApp(
            navigatorKey: navigatorKey,
            home: FutureBuilder(
              future: getIt.allReady(),
              builder: (_, snapshot) =>
                  snapshot.hasData ? Observer(builder: (_) => authController.authorized ? MainView() : LoginView()) : LoaderScreen(),
            ),
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            theme: CupertinoThemeData(
              scaffoldBackgroundColor: backgroundColor,
              primaryColor: mainColor,
              textTheme: cupertinoTextTheme.copyWith(
                primaryColor: mainColor,
                textStyle: cupertinoTextTheme.textStyle.copyWith(fontFamily: fontFamily),
              ),
            ),
            routes: {
              SourceListView.routeName: (_) => SourceListView(),
              SettingsView.routeName: (_) => SettingsView(),
              AccountView.routeName: (_) => AccountView(),
              WorkspaceListView.routeName: (_) => WorkspaceListView(),
            },
            onGenerateRoute: (RouteSettings rs) {
              if (rs.name == TaskView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => TaskView(rs.arguments as int?));
              }
              return null;
            },
          ),
          if (loaderController.stack > 0) LoaderScreen(),
        ]),
      ),
    );
  }
}
