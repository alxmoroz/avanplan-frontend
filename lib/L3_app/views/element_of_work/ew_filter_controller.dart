// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../extra/services.dart';

part 'ew_filter_controller.g.dart';

class EWFilterController extends _EWFilterControllerBase with _$EWFilterController {}

abstract class _EWFilterControllerBase with Store {
  // TODO: здесь можно заменить на EW для подзадач и использовать в дашборде задач и цели. И перенести в контроллер EWViewController
  // TODO: инициализировать родителем (выбранная цель)

  Iterable<ElementOfWork> get _allEW => ewViewController.goals;
  @computed
  int get allEWCount => _allEW.length;

  @computed
  Iterable<ElementOfWork> get openedEW => _allEW.where((e) => !e.closed);
  @computed
  int get openedEWCount => openedEW.length;
  @computed
  bool get hasOpened => openedEWCount > 0;

  @computed
  Iterable<ElementOfWork> get timeBoundEW => openedEW.where((e) => e.dueDate != null);
  @computed
  int get _timeBoundEWCount => timeBoundEW.length;
  @computed
  bool get hasTimeBound => _timeBoundEWCount > 0;

  @computed
  Iterable<ElementOfWork> get overdueEW => timeBoundEW.where((e) => e.overallState == OverallState.overdue);
  @computed
  int get overdueEWCount => overdueEW.length;
  @computed
  bool get hasOverdue => overdueEWCount > 0;

  @computed
  Iterable<ElementOfWork> get riskyEW => timeBoundEW.where((e) => e.overallState == OverallState.risk);
  @computed
  int get riskyEWCount => riskyEW.length;
  @computed
  bool get hasRisk => riskyEWCount > 0;

  @computed
  Iterable<ElementOfWork> get noDueEW => openedEW.where((e) => e.dueDate == null);
  @computed
  int get noDueEWCount => noDueEW.length;
  @computed
  bool get hasNoDue => noDueEWCount > 0;

  @computed
  Iterable<ElementOfWork> get okEW => timeBoundEW.where((e) => e.overallState == OverallState.ok);
  @computed
  int get okEWCount => okEW.length;
  @computed
  bool get hasOk => okEWCount > 0;

  @computed
  Iterable<ElementOfWork> get _activeEW => openedEW.where((e) => e.closedEWCount > 0);
  @computed
  Iterable<ElementOfWork> get closableEW => _activeEW.where((e) => e.leftEWCount == 0);
  @computed
  int get closableEWCount => closableEW.length;
  @computed
  bool get hasClosable => closableEWCount > 0;

  @computed
  Iterable<ElementOfWork> get inactiveEW => openedEW.where((e) => e.closedEWCount == 0);
  @computed
  int get inactiveEWCount => inactiveEW.length;
  @computed
  bool get hasInactive => inactiveEWCount > 0;

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
  EWFilter? ewFilter;

  @action
  void setFilter(EWFilter? _ewFilter) => ewFilter = _ewFilter;

  @action
  void setDefaultFilter() => setFilter(ewFilterKeys.contains(EWFilter.opened) ? EWFilter.opened : EWFilter.all);

  @computed
  List<EWFilter> get ewFilterKeys {
    final keys = <EWFilter>[];
    if (hasOverdue && overdueEWCount < allEWCount) {
      keys.add(EWFilter.overdue);
    }
    if (hasRisk && riskyEWCount < allEWCount) {
      keys.add(EWFilter.risky);
    }
    if (hasNoDue && noDueEWCount < allEWCount) {
      keys.add(EWFilter.noDue);
    }
    if (hasInactive && inactiveEWCount < allEWCount) {
      keys.add(EWFilter.inactive);
    }
    if (hasClosable && closableEWCount < allEWCount) {
      keys.add(EWFilter.closable);
    }
    if (hasOk && okEWCount < allEWCount) {
      keys.add(EWFilter.ok);
    }
    if (hasOpened && openedEWCount < allEWCount) {
      keys.add(EWFilter.opened);
    }
    keys.add(EWFilter.all);
    return keys;
  }

  @computed
  bool get hasFilters => ewFilterKeys.length > 1;

  @computed
  Map<EWFilter, Iterable<ElementOfWork>> get ewFilters => {
        EWFilter.overdue: overdueEW,
        EWFilter.risky: riskyEW,
        EWFilter.noDue: noDueEW,
        EWFilter.inactive: inactiveEW,
        EWFilter.closable: closableEW,
        EWFilter.opened: openedEW,
        EWFilter.ok: okEW,
        EWFilter.all: _allEW,
      };

  @computed
  Iterable<ElementOfWork> get filteredEW => ewFilters[ewFilter] ?? openedEW;
}
