// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/images.dart';
import '../../../../components/page.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MTPage(
      appBar: const MTAppBar(),
      body: SafeArea(
        child: MTAdaptive(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                MTImage(ImageName.no_info.name),
                const SizedBox(height: P3),
                H2(loc.error_404_task_title, align: TextAlign.center),
                const SizedBox(height: P),
                BaseText(loc.error_404_task_description, align: TextAlign.center),
                const SizedBox(height: P3),
                if (Navigator.of(context).canPop()) MTButton.secondary(titleText: loc.back_action_title, onTap: () => Navigator.of(context).pop()),
                const SizedBox(height: P12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
