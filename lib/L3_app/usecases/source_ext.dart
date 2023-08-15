// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/source.dart';
import '../extra/services.dart';

extension SourceExt on Source {
  Future<bool> checkConnection() async {
    bool connected = false;
    state = SrcState.checking;
    connected = await sourceUC.checkConnection(this);
    state = connected ? SrcState.connected : SrcState.error;
    mainController.touchWorkspaces();
    return connected;
  }
}
