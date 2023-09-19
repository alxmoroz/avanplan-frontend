// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'adaptive.dart';

enum ImageName {
  app_icon,
  delete,
  empty_sources,
  empty_tasks,
  empty_team,
  fs_analytics,
  fs_estimates,
  fs_goals,
  fs_task_board,
  fs_task_list,
  fs_team,
  hello,
  import,
  loading,
  network_error,
  no_info,
  ok,
  overdue,
  privacy,
  purchase,
  risk,
  save,
  server_error,
  start,
  sync,
  transfer,
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
