// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';
import '../../usecases/ws_actions.dart';
import '../../views/_base/loadable.dart';
import 'tariff_confirm_expenses_dialog.dart';

part 'tariff_controller.g.dart';

class TariffController extends _TariffSelectorControllerBase with _$TariffController {
  TariffController(int wsId) {
    _wsId = wsId;
  }
}

abstract class _TariffSelectorControllerBase with Store, Loadable {
  late final int _wsId;
  Workspace get ws => wsMainController.ws(_wsId);

  @observable
  String reason = '';

  @observable
  List<Tariff> tariffs = [];

  @action
  Future reload() async {
    setLoaderScreenLoading();
    await load(() async {
      tariffs = (await tariffUC.getAll(_wsId)).sorted((t1, t2) => compareNatural('$t1', '$t2')).sorted((t1, t2) => t1.tier.compareTo(t2.tier));
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
    if (!ws.invoice.hasOverdraft(tariff) || await tariffConfirmExpenses(ws, tariff) == true) {
      // проверка, что хватит денег на один день после смены
      if (await ws.checkBalance(loc.tariff_change_action_title, extraMoney: ws.invoice.currentExpensesPerDay)) {
        setLoaderScreenSaving();
        await load(() async {
          final signedInvoice = await contractUC.sign(tariff.id!, _wsId);
          if (signedInvoice != null) {
            await wsMainController.reloadWS(_wsId);
          }
        });
        if (context.mounted) Navigator.of(context).pop();
      }
    }
  }
}
