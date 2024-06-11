// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';
import '../../usecases/ws_actions.dart';
import '../../views/_base/loadable.dart';
import '../workspace/ws_controller.dart';
import 'tariff_confirm_expenses_dialog.dart';

part 'tariff_selector_controller.g.dart';

class TariffSelectorController extends _TariffSelectorControllerBase with _$TariffSelectorController {
  TariffSelectorController(WSController wsController) {
    _wsController = wsController;
  }
}

abstract class _TariffSelectorControllerBase with Store, Loadable {
  late final WSController _wsController;
  Workspace get wsd => _wsController.wsDescriptor;
  Workspace get ws => _wsController.ws;
  Invoice get _invoice => ws.invoice;

  @observable
  String reason = '';

  @observable
  List<Tariff> tariffs = [];

  @action
  Future reload() async {
    setLoaderScreenLoading();
    await load(() async {
      tariffs = (await tariffUC.getAll(wsd.id!)).sorted((t1, t2) => compareNatural('$t1', '$t2')).sorted((t1, t2) => t1.tier.compareTo(t2.tier));
      pageIndex = suggestedTariffIndex;
    });
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

  Future changeTariff(BuildContext context, Tariff tariff) async {
    // проверка на возможное превышение лимитов по выбранному тарифу
    if (!_invoice.hasOverdraft(tariff) || await tariffConfirmExpenses(_invoice, tariff) == true) {
      // проверка, что хватит денег на один день после смены
      if (await ws.checkBalance(loc.tariff_change_action_title, extraMoney: _invoice.currentExpensesPerDay)) {
        setLoaderScreenSaving();
        await load(() async {
          final signedInvoice = await contractUC.sign(tariff.id!, wsd.id!);
          if (signedInvoice != null) {
            await _wsController.reload();
          }
        });
        if (context.mounted) Navigator.of(context).pop();
      }
    }
  }
}
