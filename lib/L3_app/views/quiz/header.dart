// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import 'quiz_controller.dart';

class QuizHeader extends StatelessWidget implements PreferredSizeWidget {
  const QuizHeader(this._controller);
  final QuizController _controller;

  Widget _stepMark(BuildContext context, int index) {
    final isCurrent = _controller.stepIndex == index;
    final r1 = isCurrent ? P2 : P;
    final r2 = r1 - P_3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: P_3),
      child: CircleAvatar(
        radius: r1,
        backgroundColor: (isCurrent ? mainColor : f3Color).resolve(context),
        child: CircleAvatar(
          radius: r2,
          child: isCurrent ? D5('${_controller.stepIndex + 1}', color: mainColor) : null,
          backgroundColor: b2Color.resolve(context),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(P10);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _controller.active
          ? MTAppBar(
              leading: MTButton(
                titleText: loc.back_action_title,
                padding: const EdgeInsets.only(left: P2),
                onTap: () => _controller.back(context),
              ),
              middle: _controller.stepsCount > 1
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var index = 0; index < _controller.stepsCount; index++) _stepMark(context, index),
                      ],
                    )
                  : null,
              bottom: _controller.stepTitle.trim().isNotEmpty
                  ? BaseText.medium(
                      _controller.stepTitle,
                      maxLines: 1,
                      padding: const EdgeInsets.only(top: P, bottom: P),
                    )
                  : null,
              height: preferredSize.height,
              trailing: _controller.stepIndex < _controller.stepsCount - 1
                  ? MTButton(
                      titleText: loc.skip_action_title,
                      padding: const EdgeInsets.only(right: P2),
                      onTap: () => _controller.finish(context),
                    )
                  : null,
            )
          : MTAppBar(height: preferredSize.height),
    );
  }
}
