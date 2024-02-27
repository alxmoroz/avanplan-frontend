// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../components/vertical_toolbar_controller.dart';

part 'left_menu_controller.g.dart';

class LeftMenuController extends _LeftMenuControllerBase with _$LeftMenuController {}

abstract class _LeftMenuControllerBase extends VerticalToolbarController with Store {
  @override
  double get wideWidth => 242.0;
}
