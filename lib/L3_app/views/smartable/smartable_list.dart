// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/smartable.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../../L3_app/extra/services.dart';
import 'smartable_card.dart';

class SmartableList extends StatelessWidget {
  const SmartableList(this.elements);

  // TODO: формировать тут внутри на основе входного (родительского) element
  final List<Smartable> elements;

  @override
  Widget build(BuildContext context) {
    Widget cardBuilder(BuildContext context, int index) {
      final element = elements[index];
      // TODO: переход должен быть на SmartableView
      return SmartableCard(
        element: element,
        onTap: () => element is Goal ? goalController.showGoal(context, element) : smartableViewController.showTask(context, element as Task),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: cardBuilder,
      itemCount: elements.length,
    );
  }
}
