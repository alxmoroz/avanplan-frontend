// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'L2_app/components/splash.dart';
import 'L2_app/l10n/generated/l10n.dart';
import 'L2_app/views/main/main_view.dart';
import 'extra/services.dart';

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
        builder: (_, snapshot) =>
            snapshot.hasData ? MainView() : const SplashScreen(),
      ),
      routes: {
        MainView.routeName: (_) => MainView(),
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
