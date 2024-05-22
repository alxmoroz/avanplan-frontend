// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/dialog.dart';
import '../../../extra/services.dart';
import '../controllers/task_controller.dart';
import '../widgets/transfer/transfer_selector.dart';
import '../widgets/transfer/transfer_selector_controller.dart';
import 'edit.dart';

extension LocalTransferUC on TaskController {
  Future localExport() async {
    final controller = TransferSelectorController();
    controller.getDestinationsForMove(task);
    final destination = await showMTDialog<Task>(TransferSelectorDialog(
      controller,
      loc.task_transfer_destination_hint,
      loc.task_transfer_export_empty_title,
    ));

    if (destination != null) await move(destination);
  }
}
