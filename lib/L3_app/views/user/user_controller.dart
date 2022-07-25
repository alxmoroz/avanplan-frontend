// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';

part 'user_controller.g.dart';

class UserController extends _UserControllerBase with _$UserController {}

abstract class _UserControllerBase extends BaseController with Store {
  @observable
  User? currentUser;

  @action
  Future fetchData() async {
    startLoading();
    clearData();
    currentUser = await usersUC.getCurrentUser();
    stopLoading();
  }

  @action
  void clearData() => currentUser = null;
}
