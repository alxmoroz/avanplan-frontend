// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/splash.dart';
import '../../extra/services.dart';
import 'main_dashboard_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void dispose() {
    mainController.clearData();
    super.dispose();
  }

  final Future<void> _fetchData = mainController.updateAll();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData,
      builder: (_, snapshot) => snapshot.connectionState == ConnectionState.done ? MainDashboardView() : const SplashScreen(),
    );
  }
}
