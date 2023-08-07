// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/system/errors.dart';
import '../extra/services.dart';
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
        topBar: MTTopBar(titleText: loc.error_title, onClose: onClose),
        topBarColor: warningBgColor.resolve(context),
        bgColor: warningBgColor.resolve(context).withAlpha(235),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: P),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const SizedBox(height: P),
              MediumText(error.code),
              if (error.detail?.isNotEmpty == true) ...[
                const SizedBox(height: P_2),
                NormalText(error.detail!),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
