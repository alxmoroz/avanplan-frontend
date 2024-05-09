// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

part 'loadable.g.dart';

mixin Loadable {
  final l = _Loadable();
}

class _Loadable extends _LoadableBase with _$_Loadable {}

abstract class _LoadableBase with Store {
  @observable
  bool loading = true;

  @action
  void startLoading() => loading = true;

  @action
  void stopLoading() => loading = false;
}
