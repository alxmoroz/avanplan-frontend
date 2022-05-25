// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../extra/services.dart';

part 'ew_filter_controller.g.dart';

class EWFilterController extends _EWFilterControllerBase with _$EWFilterController {}

abstract class _EWFilterControllerBase with Store {
  // TODO: здесь можно заменить на EW для подзадач и использовать в дашборде задач и цели. И перенести в контроллер EWViewController
  // TODO: инициализировать родителем (выбранная цель)

  Iterable<ElementOfWork> get allEW => goalController.goals;

  @computed
  Iterable<ElementOfWork> get openedEW => allEW.where((e) => !e.closed);

  @computed
  Iterable<ElementOfWork> get timeBoundEW => openedEW.where((e) => e.dueDate != null);

  @computed
  Iterable<ElementOfWork> get overdueEW => timeBoundEW.where((e) => e.overallState == OverallState.overdue);

  @computed
  Iterable<ElementOfWork> get riskyEW => timeBoundEW.where((e) => e.overallState == OverallState.risk);

  @computed
  Iterable<ElementOfWork> get okEW => timeBoundEW.where((e) => e.overallState == OverallState.ok);

  @computed
  Iterable<ElementOfWork> get noDueEW => openedEW.where((e) => e.dueDate == null);

  @computed
  Iterable<ElementOfWork> get _activeEW => openedEW.where((e) => e.closedEWCount > 0);

  @computed
  Iterable<ElementOfWork> get closableEW => _activeEW.where((e) => e.leftEWCount == 0);

  @computed
  Iterable<ElementOfWork> get inactiveEW => openedEW.where((e) => e.closedEWCount == 0);

  @computed
  Duration get overduePeriod {
    int totalSeconds = 0;
    overdueEW.forEach((g) => totalSeconds += g.overduePeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  @computed
  Duration get riskPeriod {
    int totalSeconds = 0;
    riskyEW.forEach((g) => totalSeconds += g.etaRiskPeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  @observable
  EWFilter? ewFilter = EWFilter.opened;

  @action
  void setFilter(EWFilter? _ewFilter) => ewFilter = _ewFilter;

  @computed
  Map<EWFilter, Iterable<ElementOfWork>> get ewFilters => {
        EWFilter.all: allEW,
        EWFilter.opened: openedEW,
        EWFilter.overdue: overdueEW,
        EWFilter.risky: riskyEW,
        EWFilter.ok: okEW,
        EWFilter.noDue: noDueEW,
        EWFilter.closable: closableEW,
        EWFilter.inactive: inactiveEW,
      };

  @computed
  Iterable<ElementOfWork> get filteredEW => ewFilters[ewFilter] ?? openedEW;
}
