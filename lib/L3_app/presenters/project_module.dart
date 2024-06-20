// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../extra/services.dart';
import '../usecases/project_module.dart';

extension ProjectModulePresenter on Task {
  String get localizedModules => [loc.tariff_option_tasks_title, ...selectedProjectOptions.map((fs) => fs.title)].join(', ');
}
