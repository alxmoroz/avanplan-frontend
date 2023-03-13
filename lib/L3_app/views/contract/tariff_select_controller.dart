// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../extra/services.dart';

part 'tariff_select_controller.g.dart';

class TariffSelectController extends _TariffSelectControllerBase with _$TariffSelectController {
  TariffSelectController(int _wsId) {
    wsId = _wsId;
  }
}

abstract class _TariffSelectControllerBase with Store {
  late int wsId;

  @observable
  Iterable<Tariff> tariffs = [];

  @action
  Future fetchData() async {
    loaderController.start();
    tariffs = await tariffUC.getAll(wsId);
    loaderController.stop();
  }

  @action
  void clearData() => tariffs = [];
}
