// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'adaptive.dart';

enum ImageName {
  app_icon,
  delete,
  done,
  empty_sources,
  empty_tasks,
  empty_team,
  fs_analytics,
  fs_estimates,
  fs_goals,
  fs_task_board,
  fs_task_list,
  fs_team,
  goal,
  goal_done,
  hello,
  import,
  loading,
  network_error,
  no_info,
  notifications,
  ok,
  overdue,
  privacy,
  purchase,
  risk,
  save,
  server_error,
  sync,
  transfer,
}

String _assetPath(String name, BuildContext context) {
  final _dark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
  return 'assets/images/$name${_dark ? '_dark' : ''}.png';
}

AssetImage mtAssetImage(BuildContext context, String name) => AssetImage(_assetPath(name, context));

class MTImage extends StatelessWidget {
  const MTImage(this.name, {this.height, this.width});
  final String name;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final h = height ?? defaultImageHeight(context);
    final w = width ?? h;

    return Image.asset(
      _assetPath(name, context),
      width: width,
      height: height,
      errorBuilder: (_, __, ___) => Image.asset(
        _assetPath('no_info', context),
        width: w,
        height: h,
      ),
    );
  }
}
