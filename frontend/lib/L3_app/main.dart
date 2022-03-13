// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'components/splash.dart';
import 'extra/services.dart';
import 'l10n/generated/l10n.dart';
import 'views/auth/login_view.dart';
import 'views/goal/goal_view.dart';
import 'views/main/main_view.dart';

void main() {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Hercules',
      home: FutureBuilder(
        future: getIt.allReady(),
        builder: (_, snapshot) => snapshot.hasData ? (mainController.authorized ? MainView() : LoginView()) : const SplashScreen(),
      ),
      routes: {
        LoginView.routeName: (_) => LoginView(),
        MainView.routeName: (_) => MainView(),
        GoalView.routeName: (_) => GoalView(),
      },
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
