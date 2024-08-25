// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../components/constants.dart';

part 'task_view_controller.g.dart';

class TaskViewController extends _Base with _$TaskViewController {}

abstract class _Base with Store {
  @observable
  BoxConstraints centerConstraints = const BoxConstraints(maxWidth: SCR_S_WIDTH, maxHeight: SCR_S_HEIGHT);
  @action
  void setCenterConstraints(BoxConstraints constraints) {
    if (centerConstraints != constraints) centerConstraints = constraints;
  }
}
