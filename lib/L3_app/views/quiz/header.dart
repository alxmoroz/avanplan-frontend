// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import 'quiz_controller.dart';

AppBar quizHeader(BuildContext context, QuizController _controller) {
  Widget stepMark(int index) {
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

  return _controller.active
      ? MTAppBar(
          context,
          leadingWidth: P12,
          leading: MTButton(
            titleText: loc.back_action_title,
            padding: const EdgeInsets.only(left: P2),
            onTap: () => _controller.back(context),
          ),
          middle: _controller.stepsCount > 1
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var index = 0; index < _controller.stepsCount; index++) stepMark(index),
                  ],
                )
              : BaseText.medium(_controller.stepTitle, maxLines: 1),
          bottom: _controller.stepsCount > 1 && _controller.stepTitle.trim().isNotEmpty
              ? PreferredSize(
                  child: BaseText.medium(_controller.stepTitle, padding: const EdgeInsets.only(bottom: P), maxLines: 1),
                  preferredSize: Size.fromHeight(const BaseText.medium('', maxLines: 1).style(context).fontSize ?? P2 + P),
                )
              : null,
          trailing: _controller.stepIndex < _controller.stepsCount - 1
              ? MTButton(
                  titleText: loc.skip_action_title,
                  padding: const EdgeInsets.only(right: P2),
                  onTap: () => _controller.finish(context),
                )
              : null,
        )
      : MTAppBar(context);
}
