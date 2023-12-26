// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../components/constants.dart';

part 'vertical_toolbar_controller.g.dart';

abstract class VerticalToolbarController extends _VerticalToolbarControllerBase with _$VerticalToolbarController {}

abstract class _VerticalToolbarControllerBase with Store {
  @observable
  bool compact = false;

  @computed
  double get wideWidth => 300.0;
  @computed
  double get compactWidth => P12;

  @computed
  double get width => compact ? compactWidth : wideWidth;

  @mustCallSuper
  @action
  void toggleWidth() => compact = !compact;

  @action
  void swiped(DragUpdateDetails details) => compact = details.delta.dx < 0;
}
