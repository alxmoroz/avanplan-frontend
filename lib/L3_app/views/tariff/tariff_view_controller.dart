// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/tariff.dart';

part 'tariff_view_controller.g.dart';

class TariffViewController extends _TariffViewControllerBase with _$TariffViewController {
  TariffViewController(Tariff t) {
    tariff = t;
  }
}

abstract class _TariffViewControllerBase with Store {
  @observable
  Tariff? tariff;
}
