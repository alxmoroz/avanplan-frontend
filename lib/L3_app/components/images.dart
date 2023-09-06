// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'adaptive.dart';

class ImageNames {
  static const delete = 'delete';
  static const emptySources = 'empty_sources';
  static const emptyTasks = 'empty_tasks';
  static const emptyTeam = 'empty_team';
  static const fsAnalytics = 'fs_analytics';
  static const fsEstimates = 'fs_estimates';
  static const fsGoals = 'fs_goals';
  static const fsTaskBoard = 'fs_task_board';
  static const fsTaskList = 'fs_task_list';
  static const fsTeam = 'fs_team';
  static const import = 'import';
  static const loading = 'loading';
  static const networkError = 'network_error';
  static const noInfo = 'no_info';
  static const ok = 'ok';
  static const overdue = 'overdue';
  static const privacy = 'privacy';
  static const purchase = 'purchase';
  static const risk = 'risk';
  static const save = 'save';
  static const serverError = 'server_error';
  static const start = 'start';
  static const sync = 'sync';
  static const transfer = 'transfer';
}

class MTImage extends StatelessWidget {
  const MTImage(this.name, {this.height, this.width});
  final String name;
  final double? height;
  final double? width;

  String _assetPath(String name, BuildContext context) {
    final _dark = View.of(context).platformDispatcher.platformBrightness == Brightness.dark;
    return 'assets/images/$name${_dark ? '_dark' : ''}.png';
  }

  @override
  Widget build(BuildContext context) {
    final _h = height ?? dashboardImageHeight(context);
    final _w = width ?? _h;

    return Image.asset(
      _assetPath(name, context),
      width: _w,
      height: _h,
      errorBuilder: (_, __, ___) => Image.asset(
        _assetPath('no_info', context),
        width: _w,
        height: _h,
      ),
    );
  }
}
