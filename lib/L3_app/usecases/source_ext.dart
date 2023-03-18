// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/system/errors.dart';
import '../extra/services.dart';

extension SourceExt on Source {
  Future<bool> checkConnection() async {
    bool connected = false;
    try {
      state = SrcState.checking;
      mainController.touchWorkspaces();

      connected = await sourceUC.checkConnection(this);
      state = connected ? SrcState.connected : SrcState.error;
      mainController.touchWorkspaces();
    } on MTImportError {
      state = SrcState.error;
      mainController.touchWorkspaces();
    }
    return connected;
  }
}
