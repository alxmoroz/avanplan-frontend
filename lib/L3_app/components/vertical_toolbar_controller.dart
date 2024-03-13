// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import 'constants.dart';

part 'vertical_toolbar_controller.g.dart';

class VerticalToolbarController extends _VerticalToolbarControllerBase with _$VerticalToolbarController {
  VerticalToolbarController({bool isCompact = false, double wideWidth = 278.0}) {
    compact = isCompact;
    _wideWidth = wideWidth;
    _compactWidth = P12;
  }
}

abstract class _VerticalToolbarControllerBase with Store {
  late final double _wideWidth;
  late final double _compactWidth;

  @observable
  bool compact = false;
  @action
  void setCompact(bool value) => compact = value;

  @computed
  double get width => compact ? _compactWidth : _wideWidth;

  @mustCallSuper
  @action
  void toggleWidth() => compact = !compact;
}
