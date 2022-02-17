// Copyright (c) 2022. Alexandr Moroz

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../views/auth/login_view.dart';
import 'drawer.dart';

class MainView extends StatefulWidget {
  static String get routeName => 'main';

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    mainController.initState(context);
    super.initState();
  }

  @override
  void dispose() {
    mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: appBarBgColor.resolve(context),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext innerCtx) => Button.icon(menuIcon(context), () => Scaffold.of(innerCtx).openDrawer()),
        ),
      ),
      drawer: ALDrawer(),
      body: Container(
        color: CupertinoDynamicColor.resolve(backgroundColor, context),
        child: Observer(
          builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const H2('Главный экран', align: TextAlign.center),
              if (!mainController.authorized) Button('Авторизация', () => Navigator.of(context).pushNamed(LoginView.routeName)),
              if (mainController.authorized) Button('Выйти', mainController.logout),
              SizedBox(height: padding),
              if (mainController.authorized) Button('Redmine', mainController.redmine),
            ],
          ),
        ),
      ),
    );
  }
}
