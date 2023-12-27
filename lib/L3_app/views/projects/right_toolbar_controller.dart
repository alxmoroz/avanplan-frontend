// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../components/vertical_toolbar_controller.dart';

part 'right_toolbar_controller.g.dart';

class ProjectsRightToolbarController extends _ProjectsRightToolbarControllerBase with _$ProjectsRightToolbarController {
  ProjectsRightToolbarController() {
    compact = true;
  }
}

abstract class _ProjectsRightToolbarControllerBase extends VerticalToolbarController with Store {
  @override
  double get wideWidth => 220.0;
}
