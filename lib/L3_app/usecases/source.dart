// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/remote_source.dart';
import '../extra/services.dart';

extension SourceUC on RemoteSource {
  Future<bool> checkConnection() async {
    bool ok = false;
    connectionState = RemoteSourceConnectionState.checking;
    try {
      ok = await remoteSourcesUC.checkConnection(this);
    } catch (_) {}

    connectionState = ok ? RemoteSourceConnectionState.connected : RemoteSourceConnectionState.error;
    wsMainController.refreshUI();
    return ok;
  }
}
