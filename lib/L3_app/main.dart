// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'components/colors.dart';
import 'components/splash.dart';
import 'extra/services.dart';
import 'l10n/generated/l10n.dart';
import 'views/auth/login_view.dart';
import 'views/goal/goal_view.dart';
import 'views/import/import_view.dart';
import 'views/main/main_view.dart';
import 'views/remote_tracker/tracker_list_view.dart';
import 'views/task/task_edit_view.dart';
import 'views/task/task_view.dart';

void main() {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Brightness platformBrightness = WidgetsBinding.instance!.window.platformBrightness;

    return Theme(
      data: ThemeData(
        brightness: platformBrightness,
        primarySwatch: platformBrightness == Brightness.light ? darkTealColorMaterial : tealColorMaterial,
      ),
      child: CupertinoApp(
        home: FutureBuilder(
          future: getIt.allReady(),
          builder: (_, snapshot) => snapshot.hasData ? (loginController.authorized ? MainView() : LoginView()) : const SplashScreen(),
        ),
        routes: {
          LoginView.routeName: (_) => LoginView(),
          MainView.routeName: (_) => MainView(),
          GoalView.routeName: (_) => GoalView(),
          TaskView.routeName: (_) => TaskView(),
          TaskEditView.routeName: (_) => TaskEditView(),
          TrackerListView.routeName: (_) => TrackerListView(),
          ImportView.routeName: (_) => ImportView(),
        },
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: const CupertinoThemeData(primaryColor: mainColor),
      ),
    );
  }
}
