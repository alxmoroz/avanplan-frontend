// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

mixin Loadable {
  @observable
  bool loading = true;

  @action
  void startLoading() => loading = true;

  @action
  void stopLoading() => loading = false;
}
