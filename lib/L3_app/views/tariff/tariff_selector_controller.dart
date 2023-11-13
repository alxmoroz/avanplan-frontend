// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';
import '../../presenters/number.dart';
import '../../usecases/ws_actions.dart';
import '../iap/iap_view.dart';

part 'tariff_selector_controller.g.dart';

class TariffSelectorController extends _TariffSelectorControllerBase with _$TariffSelectorController {
  TariffSelectorController(int wsId, String reason) {
    _wsId = wsId;
    reason = reason;
  }
}

abstract class _TariffSelectorControllerBase with Store {
  late final int _wsId;
  Workspace get ws => wsMainController.ws(_wsId);

  @observable
  String reason = '';

  @observable
  List<Tariff> tariffs = [];

  @observable
  bool loading = true;

  @action
  Future getData() async {
    loading = true;
    tariffs = (await tariffUC.getAll(_wsId)).sorted((t1, t2) => compareNatural('$t1', '$t2')).sorted((t1, t2) => t1.tier.compareTo(t2.tier));
    pageIndex = suggestedTariffIndex;
    loading = false;
  }

  @computed
  int get activeTariffIndex => tariffs.indexWhere((t) => t.id == ws.invoice.tariff.id);

  @computed
  int get suggestedTariffIndex => activeTariffIndex < tariffs.length && reason.isNotEmpty ? activeTariffIndex + 1 : activeTariffIndex;

  @observable
  int? pageIndex;

  @action
  void pageChanged(int pIndex) => pageIndex = pIndex;

  @computed
  int get pagesCount => tariffs.length + (ws.hpTariffUpdate ? 1 : 0);

  bool showPageButton(bool left) => pageIndex != null && left ? pageIndex! > 0 : pageIndex! < pagesCount - 1;

  Future selectTariff(BuildContext context, Tariff tariff) async {
    final balanceLack = tariff.estimateChargePerBillingPeriod - ws.balance;
    if (balanceLack <= 0) {
      Navigator.of(context).pop(tariff);
    } else {
      await replenishBalanceDialog(_wsId, reason: loc.error_tariff_insufficient_funds_for_change('${balanceLack.currency}₽'));
    }
  }
}
