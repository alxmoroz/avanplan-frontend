// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../navigation/route.dart';

class Task404Route extends MTRoute {
  static const staticBaseName = '404';

  Task404Route({super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, __) => const _Task404Dialog(),
        );

  @override
  bool isDialog(BuildContext context) => true;
}

class _Task404Dialog extends StatelessWidget {
  const _Task404Dialog();

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      body: ListView(
        shrinkWrap: true,
        children: [
          MTImage(ImageName.no_info.name),
          H2(
            loc.error_404_task_title,
            align: TextAlign.center,
            padding: const EdgeInsets.all(P3),
          ),
          BaseText(
            loc.error_404_task_description,
            align: TextAlign.center,
            padding: const EdgeInsets.symmetric(horizontal: P6),
          ),
          const SizedBox(height: P3),
        ],
      ),
    );
  }
}
