// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';

class _TaskNotFoundRoute extends MTRoute {
  _TaskNotFoundRoute()
      : super(
          path: '404',
          name: 'task404',
          builder: (_, __) => const _TaskNotFoundDialog(),
        );

  @override
  bool isDialog(BuildContext _) => true;

  @override
  String? title(GoRouterState _) => loc.my_account_title;
}

// не нужно объявлять в маршрутах, не должно быть диплинков сюда
final taskNotFoundRoute = _TaskNotFoundRoute();

class _TaskNotFoundDialog extends StatelessWidget {
  const _TaskNotFoundDialog();

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: const MTAppBar(showCloseButton: true, color: b2Color),
      body: Center(
        child: ListView(
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
      ),
    );
  }
}
