// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/invoice.dart';

part 'tariff_view_controller.g.dart';

class TariffViewController extends _TariffViewControllerBase with _$TariffViewController {
  TariffViewController(Invoice _invoice) {
    invoice = _invoice;
  }
}

abstract class _TariffViewControllerBase with Store {
  @observable
  Invoice? invoice;
}
