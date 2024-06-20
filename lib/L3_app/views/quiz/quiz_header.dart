// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import 'abstract_quiz_controller.dart';

class QuizHeader extends StatelessWidget implements PreferredSizeWidget {
  const QuizHeader(this._controller, {super.key});
  final AbstractQuizController _controller;

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
          backgroundColor: b2Color.resolve(context),
          child: isCurrent ? DSmallText.bold('${_controller.stepIndex + 1}', color: mainColor) : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(P8 + P);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTAppBar(
        innerHeight: preferredSize.height,
        color: isBigScreen(context) ? b2Color : null,
        leading: _controller.stepIndex > 0 || _controller.step.awaiting
            ? MTButton(
                titleText: loc.back_action_title,
                padding: const EdgeInsets.only(left: P2),
                onTap: _controller.back,
              )
            : const SizedBox(),
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
                align: TextAlign.center,
                maxLines: 1,
                padding: const EdgeInsets.symmetric(vertical: P, horizontal: P3),
              )
            : null,
        trailing: _controller.stepIndex < _controller.stepsCount - 1
            ? MTButton(
                titleText: loc.skip_action_title,
                padding: const EdgeInsets.only(right: P2),
                onTap: _controller.finish,
              )
            : null,
      ),
    );
  }
}
