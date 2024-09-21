// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/source.dart';
import '../extra/services.dart';

extension SourceUC on Source {
  Future<bool> checkConnection() async {
    bool connected = false;
    state = SrcState.checking;
    try {
      connected = await wsSourcesUC.checkConnection(this);
    } catch (_) {}

    state = connected ? SrcState.connected : SrcState.error;
    wsMainController.refreshUI();
    return connected;
  }
}
