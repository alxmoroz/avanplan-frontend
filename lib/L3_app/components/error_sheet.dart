// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import '../../L1_domain/entities/errors.dart';
import '../presenters/communications.dart';
import 'adaptive.dart';
import 'colors.dart';
import 'constants.dart';
import 'text.dart';
import 'toolbar.dart';

class MTErrorSheet extends StatelessWidget {
  const MTErrorSheet(this.error, {super.key, this.onClose});

  final MTError error;
  final VoidCallback? onClose;

  static const _radius = Radius.circular(DEF_BORDER_RADIUS);

  @override
  Widget build(BuildContext context) {
    return MTAdaptive(
      force: true,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: warningLightColor.resolve(context),
          borderRadius: const BorderRadius.only(
            topLeft: _radius,
            topRight: _radius,
          ),
        ),
        child: Column(
          children: [
            ToolBar(
              showCloseButton: true,
              color: warningDarkColor,
              middle: BaseText.medium(
                error.title,
                maxLines: 2,
                padding: const EdgeInsets.symmetric(horizontal: P8),
              ),
              onClose: onClose,
            ),
            if (error.description?.isNotEmpty == true) ...[
              const SizedBox(height: P),
              BaseText(
                error.description!,
                padding: const EdgeInsets.symmetric(horizontal: P2),
              ),
            ],
            const SizedBox(height: P),
            ReportErrorButton(
              error.detail ?? error.description ?? error.title,
              color: warningLightColor,
              titleColor: warningColor,
            ),
            SizedBox(height: max(MediaQuery.paddingOf(context).bottom, P3))
          ],
        ),
      ),
    );
  }
}
