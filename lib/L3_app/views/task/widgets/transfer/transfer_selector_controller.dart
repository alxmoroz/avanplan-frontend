// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../views/_base/loadable.dart';

part 'transfer_selector_controller.g.dart';

class TransferSelectorController extends _TransferSelectorControllerBase with _$TransferSelectorController {}

abstract class _TransferSelectorControllerBase with Store, Loadable {
  List<Task> tasks = [];

  // перенос из других целей, бэклогов, проектов
  Future getSourcesForMove(Task dst) async => await load(
        () async {
          tasks = [];
          for (Workspace ws in wsMainController.workspaces) {
            tasks.addAll(await wsTransferUC.sourcesForMove(ws.id!));
          }
          tasks.removeWhere((t) => t.wsId == dst.wsId && t.id == dst.id);
          tasks.sort();
        },
      );

  // перенос в другую цель, проект
  Future getDestinationsForMove(Task src) async => await load(
        () async {
          tasks = [];
          for (Workspace ws in wsMainController.workspaces) {
            tasks.addAll(await wsTransferUC.destinationsForMove(ws.id!, src.type));
          }
          tasks.removeWhere((t) => t.wsId == src.parent?.wsId && t.id == src.parentId);
          tasks.sort();
        },
      );
}
