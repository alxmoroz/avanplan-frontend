// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../components/adaptive.dart';
import '../../../components/constants.dart';
import 'my_projects.dart';
import 'my_tasks.dart';

const double _BIG_WIDTH = (SCR_S_WIDTH + P4) * 2 + P4;
const double _BIG_HEIGHT = SCR_S_HEIGHT;
const _MIN_HEIGHT = 240.0;

bool dashboardBigScreen(BuildContext context) {
  final _size = MediaQuery.sizeOf(context);
  return _size.width > _BIG_WIDTH && _size.height > _BIG_HEIGHT;
}

class MainDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mq = MediaQuery.of(context);
    final _topInnerPadding = (_mq.size.height > _BIG_HEIGHT ? P4 : P);
    final _bottomPadding = max(_mq.padding.bottom, P4);
    const _spacing = P4;

    double _mainAxisExtent() {
      final _mq = MediaQuery.of(context);
      final _isPortrait = _mq.orientation == Orientation.portrait;
      return min(
        SCR_XS_WIDTH,
        max(
          _MIN_HEIGHT,
          (_mq.size.height - _mq.padding.top - _bottomPadding - _topInnerPadding - _spacing) / (_isPortrait ? 2 : 1),
        ),
      );
    }

    return dashboardBigScreen(context)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: P4).copyWith(top: _topInnerPadding),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MTAdaptive.s(child: MyTasks(compact: false)),
                SizedBox(width: _spacing),
                MTAdaptive.s(child: MyProjects(compact: false)),
              ],
            ),
          )
        : GridView(
            padding: _mq.padding.add(EdgeInsets.symmetric(vertical: _topInnerPadding, horizontal: P4).copyWith(bottom: _bottomPadding)),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: SCR_S_WIDTH,
              crossAxisSpacing: _spacing,
              mainAxisExtent: _mainAxisExtent(),
              mainAxisSpacing: _spacing,
            ),
            children: const [MyTasks(), MyProjects()],
          );
  }
}
