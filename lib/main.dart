// Copyright (c) 2022. Alexandr Moroz

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'L1_domain/entities/task.dart';
import 'L1_domain/entities/user.dart';
import 'L1_domain/entities/workspace.dart';
import 'L3_app/components/colors.dart';
import 'L3_app/components/colors_base.dart';
import 'L3_app/extra/services.dart';
import 'L3_app/l10n/generated/l10n.dart';
import 'L3_app/views/account/account_view.dart';
import 'L3_app/views/auth/auth_view.dart';
import 'L3_app/views/loader/loader_screen.dart';
import 'L3_app/views/main/main_view.dart';
import 'L3_app/views/my_projects/my_projects_view.dart';
import 'L3_app/views/my_tasks/my_tasks_view.dart';
import 'L3_app/views/notification/notification_list_view.dart';
import 'L3_app/views/settings/settings_view.dart';
import 'L3_app/views/source/source_list_view.dart';
import 'L3_app/views/tariff/active_contract_view.dart';
import 'L3_app/views/task/task_view.dart';
import 'L3_app/views/task/widgets/team/member_view.dart';
import 'L3_app/views/user/user_list_view.dart';
import 'L3_app/views/user/user_view.dart';
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
            routes: {
              AccountView.routeName: (_) => AccountView(),
              NotificationListView.routeName: (_) => NotificationListView(),
              MyProjectsView.routeName: (_) => MyProjectsView(),
              MyTasksView.routeName: (_) => MyTasksView(),
              SettingsView.routeName: (_) => SettingsView(),
            },
            onGenerateRoute: (RouteSettings rs) {
              if (rs.name == UserListView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => UserListView(rs.arguments as Workspace));
              } else if (rs.name == ActiveContractView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => ActiveContractView(rs.arguments as Workspace));
              } else if (rs.name == WorkspaceView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => WorkspaceView(rs.arguments as int));
              } else if (rs.name == SourceListView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => SourceListView(rs.arguments as int));
              } else if (rs.name == TaskView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => TaskView(rs.arguments as Task));
              } else if (rs.name == MemberView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => MemberView(rs.arguments as MemberViewArgs));
              } else if (rs.name == UserView.routeName) {
                return CupertinoPageRoute<dynamic>(builder: (_) => UserView(rs.arguments as User));
              }
              return null;
            },
          ),
          if (loader.loading)
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
