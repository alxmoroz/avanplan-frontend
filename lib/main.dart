// Copyright (c) 2022. Alexandr Moroz

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'L1_domain/entities/invoice.dart';
import 'L1_domain/entities/workspace.dart';
import 'L3_app/components/colors.dart';
import 'L3_app/extra/services.dart';
import 'L3_app/l10n/generated/l10n.dart';
import 'L3_app/views/account/account_view.dart';
import 'L3_app/views/loader/loader_screen.dart';
import 'L3_app/views/main/main_view.dart';
import 'L3_app/views/members/member_view.dart';
import 'L3_app/views/notification/notification_list_view.dart';
import 'L3_app/views/settings/settings_view.dart';
import 'L3_app/views/sign_in/sign_in_view.dart';
import 'L3_app/views/source/source_list_view.dart';
import 'L3_app/views/tariff/tariff_view.dart';
import 'L3_app/views/task/task_view.dart';
import 'L3_app/views/workspace/workspace_view.dart';

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
      scaffoldBackgroundColor: backgroundColor,
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
        // brightness: WidgetsBinding.instance.window.platformBrightness,
        // colorSchemeSeed: mainColor.resolve(context),
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor.resolve(context), brightness: WidgetsBinding.instance.window.platformBrightness),
        fontFamily: fontFamily,
        useMaterial3: true,
      ),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      onGenerateRoute: (RouteSettings rs) {
        linkController.parseDeepLink(rs.name);
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
                  snapshot.hasData ? Observer(builder: (_) => authController.authorized ? MainView() : SignInView()) : LoaderScreen(),
            ),
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            theme: cupertinoTheme,
            routes: {
              SourceListView.routeName: (_) => SourceListView(),
              SettingsView.routeName: (_) => SettingsView(),
              AccountView.routeName: (_) => AccountView(),
              NotificationListView.routeName: (_) => NotificationListView(),
            },
            onGenerateRoute: (RouteSettings rs) {
              if (rs.name == TaskView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => TaskView(rs.arguments as int?));
              } else if (rs.name == MemberView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => MemberView(rs.arguments as MemberViewArgs));
              } else if (rs.name == WorkspaceView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => WorkspaceView(rs.arguments as Workspace));
              } else if (rs.name == TariffView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => TariffView(rs.arguments as Invoice));
              }
              return null;
            },
          ),
          if (loaderController.stack > 0)
            CupertinoApp(
              debugShowCheckedModeBanner: _DEBUG_BANNER,
              home: LoaderScreen(),
              localizationsDelegates: localizationsDelegates,
              supportedLocales: supportedLocales,
              theme: cupertinoTheme,
            )
        ]),
      ),
    );
  }
}
