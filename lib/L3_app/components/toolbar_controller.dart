// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import 'constants.dart';

part 'toolbar_controller.g.dart';

class MTToolbarController extends _Base with _$MTToolbarController {
  MTToolbarController({
    bool isCompact = false,
    double wideWidth = 278.0,
    double height = P10,
  }) {
    compact = isCompact;
    _height = height;
    _wideWidth = wideWidth;
    _compactWidth = kIsWeb ? P11 : P12;
  }
}

abstract class _Base with Store {
  late final double _wideWidth;
  late final double _compactWidth;

  @observable
  bool compact = false;
  @action
  void setCompact(bool value) => compact = value;

  @observable
  bool hidden = false;
  @action
  void setHidden(bool value) => hidden = value;

  @observable
  double _height = 0;
  @action
  void setHeight(double value) => _height = value;

  @computed
  double get width => hidden
      ? 0
      : compact
          ? _compactWidth
          : _wideWidth;

  @computed
  double get height => hidden ? 0 : _height;

  @mustCallSuper
  @action
  void toggleWidth() => compact = !compact;
}
