// Copyright (c) 2022. Alexandr Moroz

// TODO: сомнительный класс. Возможно, он вовсе не понадобится. Сделано было для распространения логики расчёта скоростей... На разные клиенты
//  С другой стороны, возможно, копипаст клиентской логики будет не таким уж и плохим решением. Особенно с учётом экономии ресурсов сервера для расчётов.

class GoalReport {
  GoalReport({
    this.factSpeed = 0,
    this.planSpeed = 0,
    this.etaDate,
  });

  final num factSpeed;
  final num planSpeed;
  final DateTime? etaDate;
}
