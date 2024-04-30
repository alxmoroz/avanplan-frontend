// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/route.dart';
import '../../../../extra/services.dart';

class TaskNotFoundRoute extends MTRoute {
  static const staticBaseName = '404';

  TaskNotFoundRoute({super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, __) => const _TaskNotFoundDialog(),
        );

  @override
  bool isDialog(BuildContext context) => true;

  @override
  String? title(GoRouterState state) => loc.error_404_task_title;
}

class _TaskNotFoundDialog extends StatelessWidget {
  const _TaskNotFoundDialog();

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: const MTAppBar(showCloseButton: true, color: b2Color),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTImage(ImageName.no_info.name),
          const SizedBox(height: P3),
          H2(loc.error_404_task_title, align: TextAlign.center),
          const SizedBox(height: P),
          BaseText(loc.error_404_task_description, align: TextAlign.center),
          const SizedBox(height: P3),
        ],
      ),
    );
  }
}
