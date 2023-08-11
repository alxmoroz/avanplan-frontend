// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/system/errors.dart';
import '../presenters/communications_presenter.dart';
import 'colors.dart';
import 'constants.dart';
import 'mt_adaptive.dart';
import 'mt_dialog.dart';
import 'mt_toolbar.dart';
import 'text_widgets.dart';

class MTErrorSheet extends StatelessWidget {
  const MTErrorSheet(this.error, {this.onClose});

  final MTError error;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return MTAdaptive(
      force: true,
      child: MTDialog(
        topBar: MTTopBar(
          middle: MediumText(
            error.title,
            maxLines: 2,
            padding: const EdgeInsets.symmetric(horizontal: P2 * 2),
          ),
          onClose: onClose,
        ),
        topBarColor: warningDarkColor,
        bgColor: warningLightColor,
        body: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            if (error.description?.isNotEmpty == true) ...[
              const SizedBox(height: P_2),
              NormalText(
                error.description!,
                padding: const EdgeInsets.symmetric(horizontal: P),
              ),
            ],
            const SizedBox(height: P_2),
            ReportErrorButton(
              error.detail ?? error.description ?? error.title,
              color: warningLightColor,
              titleColor: warningColor,
            ),
          ],
        ),
      ),
    );
  }
}
