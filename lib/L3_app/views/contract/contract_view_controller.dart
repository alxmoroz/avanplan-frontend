// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';
import '../tariff/tariff_select_view.dart';

part 'contract_view_controller.g.dart';

class ContractViewController extends _ContractViewControllerBase with _$ContractViewController {
  ContractViewController(Workspace _ws) {
    ws = _ws;
  }
}

abstract class _ContractViewControllerBase with Store {
  late Workspace ws;

  @observable
  List<Tariff> _tariffs = [];

  @computed
  int get _currentTariffIndex => _tariffs.indexWhere((t) => t.id == ws.invoice.tariff.id);

  @computed
  int get _selectedTariffIndex => _currentTariffIndex < _tariffs.length - 1 ? _currentTariffIndex + 1 : _currentTariffIndex;

  @action
  Future _fetchTariffs() async {
    loaderController.start();
    loaderController.setRefreshing();
    _tariffs = (await tariffUC.getAll(ws.id!)).sorted((t1, t2) => compareNatural('$t1', '$t2')).sorted((t1, t2) => t1.tier.compareTo(t2.tier));
    await loaderController.stop();
  }

  @action
  void clearData() => _tariffs = [];

  Future changeTariff(BuildContext context, Workspace ws) async {
    await _fetchTariffs();
    final tariff = await tariffSelectDialog(_tariffs, _currentTariffIndex, _selectedTariffIndex);

    if (tariff != null) {
      loaderController.start();
      loaderController.setSaving();
      final signedContractInvoice = await contractUC.sign(tariff.id!, ws.id!);
      if (signedContractInvoice != null) {
        ws.invoice = signedContractInvoice;
      }
      await loaderController.stop();
    }
  }
}
