// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/adaptive.dart';
import '../../../components/constants.dart';
import '../../../extra/services.dart';
import 'my_tasks.dart';
import 'projects.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard();

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

    final isBigS = size.width > _BIG_WIDTH_S;
    final isBig = size.width > _BIG_WIDTH_XS && size.height > _BIG_HEIGHT;
    final spacing = isBigS ? _spacing_s : _spacing_xs;

    final topInnerPadding = spacing;
    final bottomPadding = max(padding.bottom, spacing);

    final _isPortrait = MediaQuery.orientationOf(context) == Orientation.portrait;

    double _mainAxisExtent() => min(
          SCR_XXS_WIDTH,
          max(
            _MIN_HEIGHT,
            (size.height - padding.top - bottomPadding - topInnerPadding - spacing) / (_isPortrait ? 2 : 1),
          ),
        );

    return Observer(
      builder: (_) => isBig || !_hasTasks
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: topInnerPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_hasTasks) ...[
                    const Flexible(child: MTAdaptive(child: MyTasks(compact: false))),
                    SizedBox(width: spacing),
                  ],
                  const Flexible(child: MTAdaptive(child: Projects(compact: false))),
                ],
              ),
            )
          : GridView(
              padding: padding.add(EdgeInsets.symmetric(vertical: topInnerPadding, horizontal: P3).copyWith(bottom: bottomPadding)),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: SCR_S_WIDTH,
                crossAxisSpacing: spacing,
                mainAxisExtent: _mainAxisExtent(),
                mainAxisSpacing: spacing,
              ),
              children: const [MyTasks(), Projects()],
            ),
    );
  }
}
