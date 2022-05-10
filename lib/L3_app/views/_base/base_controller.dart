// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

part 'base_controller.g.dart';

//TODO: добавить сюда или в отдельный base_editController методы из SmartableController. А также canEdit, selected[T] и т.п.

abstract class BaseController = _BaseControllerBase with _$BaseController;

abstract class _BaseControllerBase with Store {
  @observable
  String? errorCode;

  @action
  void setErrorCode(String? eCode) => errorCode = eCode;

  @observable
  bool _loading = false;

  @action
  void startLoading() => _loading = true;

  @action
  void stopLoading() => _loading = false;

  @computed
  bool get isLoading => _loading;

  void clearData() => throw UnimplementedError();

  Future fetchData() => throw UnimplementedError();
}
