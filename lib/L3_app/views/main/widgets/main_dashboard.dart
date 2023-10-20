// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../components/adaptive.dart';
import '../../../components/constants.dart';
import '../../../extra/services.dart';
import 'my_projects.dart';
import 'my_tasks.dart';

class MainDashboard extends StatelessWidget {
  static const _spacing_s = P4;
  static const _spacing_xs = P2;

  static const _BIG_WIDTH_S = (SCR_S_WIDTH + _spacing_s) * 2 + _spacing_s;
  static const _BIG_WIDTH_XS = (SCR_XS_WIDTH + _spacing_xs) * 2 + _spacing_xs;
  static const _BIG_HEIGHT = SCR_S_HEIGHT;
  static const _MIN_HEIGHT = 240.0;

  bool get _hasTasks => tasksMainController.myTasks.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final size = MediaQuery.sizeOf(context);
    final topInnerPadding = (size.height > _BIG_HEIGHT ? P4 : P);
    final bottomPadding = max(padding.bottom, P4);

    final isBigS = size.width > _BIG_WIDTH_S;
    final isBig = size.width > _BIG_WIDTH_XS && size.height > _BIG_HEIGHT;
    final spacing = isBigS ? _spacing_s : _spacing_xs;

    double _mainAxisExtent() {
      final _isPortrait = MediaQuery.orientationOf(context) == Orientation.portrait;
      return min(
        SCR_XXS_WIDTH,
        max(
          _MIN_HEIGHT,
          (size.height - padding.top - bottomPadding - topInnerPadding - spacing) / (_isPortrait ? 2 : 1),
        ),
      );
    }

    return isBig || !_hasTasks
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: P4).copyWith(top: topInnerPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_hasTasks) ...[
                  MTAdaptive(
                    child: const MyTasks(compact: false),
                    size: isBigS ? AdaptiveSize.S : AdaptiveSize.XS,
                  ),
                  SizedBox(width: spacing),
                ],
                MTAdaptive(
                  child: const MyProjects(compact: false),
                  size: isBigS ? AdaptiveSize.S : AdaptiveSize.XS,
                ),
              ],
            ),
          )
        : GridView(
            padding: padding.add(EdgeInsets.symmetric(vertical: topInnerPadding, horizontal: P4).copyWith(bottom: bottomPadding)),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: SCR_S_WIDTH,
              crossAxisSpacing: spacing,
              mainAxisExtent: _mainAxisExtent(),
              mainAxisSpacing: spacing,
            ),
            children: const [MyTasks(), MyProjects()],
          );
  }
}
