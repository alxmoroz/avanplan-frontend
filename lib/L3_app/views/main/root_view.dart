// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../extra/loader/loader_screen.dart';
import '../../extra/services.dart';
import 'main_view.dart';

class RootView extends StatefulWidget {
  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  void dispose() {
    mainController.clearData();
    super.dispose();
  }

  final Future<void> _fetchData = mainController.updateAll(null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _fetchData,
      builder: (_, snapshot) => snapshot.connectionState == ConnectionState.done ? MainView() : LoaderScreen(),
    );
  }
}
