// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;
import 'package:built_collection/built_collection.dart';

import '../../L1_domain/entities/notification.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/repositories/abs_my_repo.dart';
import '../mappers/notification.dart';
import '../mappers/task.dart';
import '../mappers/user.dart';
import '../services/api.dart';
import '../services/platform.dart';

class MyRepo extends AbstractMyRepo {
  o_api.MyAccountApi get _accountApi => avanplanApi.getMyAccountApi();

  @override
  Future<User?> getAccount() async {
    final response = await _accountApi.accountV1MyAccountGet();
    return response.data?.myUser(-1);
  }

  @override
  Future deleteAccount() async => await _accountApi.deleteAccountV1MyAccountDelete();

  o_api.MyNotificationsApi get _notificationsApi => avanplanApi.getMyNotificationsApi();
  @override
  Future<Iterable<MTNotification>> getNotifications() async {
    final response = await _notificationsApi.myNotificationsV1MyNotificationsGet();
    return response.data?.map((n) => n.notification) ?? [];
  }

  @override
  Future markReadNotifications(Iterable<int> notificationsIds) async =>
      await _notificationsApi.markReadV1MyNotificationsPost(requestBody: BuiltList.from(notificationsIds));

  o_api.MyPushTokensApi get _pushTokensApi => avanplanApi.getMyPushTokensApi();

  @override
  Future updatePushToken(String token, bool hasPermission) async {
    final body = (o_api.BodyUpdatePushTokenV1MyPushTokensPostBuilder()
          ..platform = platformCode
          ..code = token
          ..hasPermission = hasPermission)
        .build();
    await _pushTokensApi.updatePushTokenV1MyPushTokensPost(bodyUpdatePushTokenV1MyPushTokensPost: body);
  }

  o_api.MyInvitationsApi get _invitationsApi => avanplanApi.getMyInvitationsApi();

  @override
  Future<TaskDescriptor?> redeemInvitation(String? token) async {
    final body = (o_api.BodyRedeemInvitationBuilder()..invitationToken = token).build();
    final response = await _invitationsApi.redeemInvitation(bodyRedeemInvitation: body);
    return response.data?.project;
  }

  // o_api.MyActivitiesApi get _activitiesApi => avanplanApi.getMyActivitiesApi();
  // @override
  // Future<User?> registerActivity(String code, {int? wsId}) async {
  //   final body = (o_api.BodyRegisterV1MyActivitiesRegisterPostBuilder()
  //         ..code = code
  //         ..wsId = wsId)
  //       .build();
  //   final response = await _activitiesApi.registerV1MyActivitiesRegisterPost(bodyRegisterV1MyActivitiesRegisterPost: body);
  //   return response.data?.myUser(-1);
  // }
}
