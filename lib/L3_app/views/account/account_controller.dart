// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'account_controller.g.dart';

class AccountController extends _AccountControllerBase with _$AccountController {}

abstract class _AccountControllerBase extends EditController with Store {
  @observable
  User? user;

  @action
  Future fetchData() async {
    startLoading();
    user = await myUC.getCurrentUser();
    stopLoading();
  }

  @action
  void clearData() => user = null;
}
