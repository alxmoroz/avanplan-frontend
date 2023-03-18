//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:openapi/src/date_serializer.dart';
import 'package:openapi/src/model/date.dart';

import 'package:openapi/src/model/app_settings_get.dart';
import 'package:openapi/src/model/body_auth_apple_token.dart';
import 'package:openapi/src/model/body_auth_google_token.dart';
import 'package:openapi/src/model/body_redeem_v1_invitation_redeem_post.dart';
import 'package:openapi/src/model/body_update_account_v1_my_account_post.dart';
import 'package:openapi/src/model/body_update_push_token_v1_my_push_token_post.dart';
import 'package:openapi/src/model/contract_get.dart';
import 'package:openapi/src/model/estimate_unit_get.dart';
import 'package:openapi/src/model/estimate_value_get.dart';
import 'package:openapi/src/model/http_validation_error.dart';
import 'package:openapi/src/model/invitation.dart';
import 'package:openapi/src/model/invoice_detail_get.dart';
import 'package:openapi/src/model/invoice_get.dart';
import 'package:openapi/src/model/location_inner.dart';
import 'package:openapi/src/model/member_get.dart';
import 'package:openapi/src/model/notification.dart';
import 'package:openapi/src/model/permission_get.dart';
import 'package:openapi/src/model/permission_role_get.dart';
import 'package:openapi/src/model/priority_get.dart';
import 'package:openapi/src/model/role_get.dart';
import 'package:openapi/src/model/settings_get.dart';
import 'package:openapi/src/model/source_get.dart';
import 'package:openapi/src/model/source_upsert.dart';
import 'package:openapi/src/model/status_get.dart';
import 'package:openapi/src/model/tariff_get.dart';
import 'package:openapi/src/model/tariff_limit_get.dart';
import 'package:openapi/src/model/tariff_option_get.dart';
import 'package:openapi/src/model/task_get.dart';
import 'package:openapi/src/model/task_remote.dart';
import 'package:openapi/src/model/task_source.dart';
import 'package:openapi/src/model/task_source_get.dart';
import 'package:openapi/src/model/task_source_upsert.dart';
import 'package:openapi/src/model/task_upsert.dart';
import 'package:openapi/src/model/token.dart';
import 'package:openapi/src/model/u_notification_permission_get.dart';
import 'package:openapi/src/model/user.dart';
import 'package:openapi/src/model/validation_error.dart';
import 'package:openapi/src/model/workspace_get.dart';

part 'serializers.g.dart';

@SerializersFor([
  AppSettingsGet,
  BodyAuthAppleToken,
  BodyAuthGoogleToken,
  BodyRedeemV1InvitationRedeemPost,
  BodyUpdateAccountV1MyAccountPost,
  BodyUpdatePushTokenV1MyPushTokenPost,
  ContractGet,
  EstimateUnitGet,
  EstimateValueGet,
  HTTPValidationError,
  Invitation,
  InvoiceDetailGet,
  InvoiceGet,
  LocationInner,
  MemberGet,
  Notification,
  PermissionGet,
  PermissionRoleGet,
  PriorityGet,
  RoleGet,
  SettingsGet,
  SourceGet,
  SourceUpsert,
  StatusGet,
  TariffGet,
  TariffLimitGet,
  TariffOptionGet,
  TaskGet,
  TaskRemote,
  TaskSource,
  TaskSourceGet,
  TaskSourceUpsert,
  TaskUpsert,
  Token,
  UNotificationPermissionGet,
  User,
  ValidationError,
  WorkspaceGet,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TaskRemote)]),
        () => ListBuilder<TaskRemote>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TaskSource)]),
        () => ListBuilder<TaskSource>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(int)]),
        () => ListBuilder<int>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Notification)]),
        () => ListBuilder<Notification>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(WorkspaceGet)]),
        () => ListBuilder<WorkspaceGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TariffGet)]),
        () => ListBuilder<TariffGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(MemberGet)]),
        () => ListBuilder<MemberGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TaskSourceUpsert)]),
        () => ListBuilder<TaskSourceUpsert>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TaskGet)]),
        () => ListBuilder<TaskGet>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
