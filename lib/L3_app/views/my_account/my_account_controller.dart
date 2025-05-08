// Copyright (c) 2024. Alexandr Moroz

import 'package:file_selector/file_selector.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../../L1_domain/entities/user_contact.dart';
import '../_base/loadable.dart';
import '../app/services.dart';

part 'my_account_controller.g.dart';

class MyAccountController extends _Base with _$MyAccountController {}

abstract class _Base with Store, Loadable {
  @observable
  User? me;

  @observable
  ObservableList<UserContact> contacts = ObservableList();

  @action
  void setContacts(Iterable<UserContact> data) => contacts = ObservableList.of(data);

  void refreshContacts() => setContacts(contacts);

  @action
  Future reload() async {
    // вызывается из mainController с его лоадером
    me = await myUC.getAccount();
    stopLoading();
  }

  // @action
  // Future registerActivity(String code, {int? wsId}) async => me = await myUC.registerActivity(code, wsId: wsId);

  @action
  Future uploadAvatar(XFile file) async {
    setLoaderScreenSaving();
    await load(() async {
      me = await myAvatarUC.uploadAvatar(
        file.openRead,
        await file.length(),
        file.name,
        await file.lastModified(),
      );
    });
    wsMainController.reload();
  }

  @action
  Future deleteAvatar() async {
    setLoaderScreenSaving();
    await load(() async {
      me = await myAvatarUC.deleteAvatar();
    });
    wsMainController.reload();
  }

  @action
  void clear() {
    me = null;
    contacts.clear();
  }
}
