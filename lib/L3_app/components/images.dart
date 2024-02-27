// Copyright (c) 2024. Alexandr Moroz

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
  mail_icon,
  network_error,
  no_info,
  notifications,
  ok,
  ok_blue,
  overdue,
  privacy,
  purchase,
  risk,
  save,
  server_error,
  sync,
  transfer,
  telegram_icon,
  upgrade,
  vk_icon,
  web_icon,
}

String _assetPath(String name, BuildContext context) {
  final dark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
  return 'assets/images/$name${dark ? '_dark' : ''}.png';
}

class MTImage extends StatelessWidget {
  const MTImage(this.name, {super.key, this.height, this.width});
  final String name;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final h = height ?? defaultImageHeight(context);
    final w = width ?? h;

    return SizedBox(
      width: w,
      height: h,
      child: Image.asset(
        _assetPath(name, context),
        // isAntiAlias: true,
        // filterQuality: FilterQuality.high,
        errorBuilder: (_, __, ___) => Image.asset(
          _assetPath('no_info', context),
        ),
      ),
    );
  }
}
