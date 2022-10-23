// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: mainController.updateAll(context),
      builder: (_, snapshot) => MainView(),
    );
  }
}
