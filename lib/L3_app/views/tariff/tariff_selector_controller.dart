// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../extra/services.dart';
import '../../usecases/ws_actions.dart';
import '../../views/_base/loadable.dart';
import '../workspace/ws_controller.dart';

part 'tariff_selector_controller.g.dart';

class TariffSelectorController extends _TariffSelectorControllerBase with _$TariffSelectorController {
  TariffSelectorController(WSController wsControllerIn) {
    wsController = wsControllerIn;
  }
}

abstract class _TariffSelectorControllerBase with Store, Loadable {
  late final WSController wsController;
  Workspace get wsd => wsController.wsDescriptor;
  Workspace get ws => wsController.ws;

  @observable
  String reason = '';

  @observable
  List<Tariff> tariffs = [];

  @action
  Future reload() async {
    setLoaderScreenLoading();
    await load(() async {
      tariffs =
          (await tariffUC.availableTariffs(wsd.id!)).sorted((t1, t2) => compareNatural('$t1', '$t2')).sorted((t1, t2) => t1.tier.compareTo(t2.tier));
      pageIndex = suggestedTariffIndex;
    });
  }

  @computed
  int get activeTariffIndex => tariffs.indexWhere((t) => t.id == ws.tariff.id);

  @computed
  int get suggestedTariffIndex => activeTariffIndex < tariffs.length && reason.isNotEmpty ? activeTariffIndex + 1 : activeTariffIndex;

  @observable
  int? pageIndex;

  @action
  void pageChanged(int pIndex) => pageIndex = pIndex;

  @computed
  int get pagesCount => tariffs.length + (ws.hpTariffUpdate ? 1 : 0);

  bool showPageButton(bool left) => pageIndex != null && left ? pageIndex! > 0 : pageIndex! < pagesCount - 1;
}
