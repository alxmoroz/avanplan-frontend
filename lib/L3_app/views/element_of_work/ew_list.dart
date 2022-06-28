// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/element_of_work.dart';
import '../../../L1_domain/entities/goal.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L3_app/extra/services.dart';
import 'ew_card.dart';

class EWList extends StatelessWidget {
  const EWList(this.elements);
  final Iterable<ElementOfWork> elements;

  @override
  Widget build(BuildContext context) {
    Widget cardBuilder(BuildContext context, int index) {
      final element = elements.elementAt(index);
      // TODO: переход должен быть на EWView
      // TODO: обработку клика делать внутри карточки
      return EWCard(
        element: element,
        onTap: () => element is Goal ? ewViewController.showGoal(context, element) : ewViewController.showTask(context, element as Task),
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
