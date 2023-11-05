// Copyright (c) 2023. Alexandr Moroz

import 'package:dio/dio.dart';

import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/entities/status.dart';
import '../../L2_data/services/api.dart';
import '../extra/services.dart';

extension StatusEditUC on Status {
  Future<Status?> edit(Future<Status?> function()) async {
    loading = true;
    statusesController.refresh();
    Status? es;
    try {
      es = await function();
    } on DioException catch (e) {
      error = MTError(loader.titleText ?? '', description: loader.descriptionText, detail: e.detail);
    }
    loading = false;
    statusesController.refresh();

    return es;
  }

  Status _update(Status es) {
    if (isNew) {
      statusesController.addStatuses([es]);
    } else {
      statusesController.setStatus(es);
    }
    return es;
  }

  Future<Status?> save() async => await edit(() async {
        final es = await statusUC.save(this);
        if (es != null) {
          return _update(es);
        }
        return null;
      });

  Future delete() async => await edit(() async {
        final es = await statusUC.delete(this);
        if (es != null) {
          statusesController.removeStatus(this);
        }
        return null;
      });
}
