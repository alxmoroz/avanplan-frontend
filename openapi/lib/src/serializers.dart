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

import 'package:openapi/src/model/account_get.dart';
import 'package:openapi/src/model/account_operation_get.dart';
import 'package:openapi/src/model/app_settings_get.dart';
import 'package:openapi/src/model/auth_token.dart';
import 'package:openapi/src/model/body_auth_apple_token.dart';
import 'package:openapi/src/model/body_auth_google_token.dart';
import 'package:openapi/src/model/body_iap_notification_v1_payments_iap_notification_post.dart';
import 'package:openapi/src/model/body_redeem_v1_my_invitations_redeem_post.dart';
import 'package:openapi/src/model/body_register_v1_my_activities_register_post.dart';
import 'package:openapi/src/model/body_registration_token.dart';
import 'package:openapi/src/model/body_request_registration.dart';
import 'package:openapi/src/model/body_request_source_type.dart';
import 'package:openapi/src/model/body_update_account_v1_my_account_post.dart';
import 'package:openapi/src/model/body_update_push_token_v1_my_push_tokens_post.dart';
import 'package:openapi/src/model/contract_get.dart';
import 'package:openapi/src/model/estimate_unit_get.dart';
import 'package:openapi/src/model/estimate_value_get.dart';
import 'package:openapi/src/model/http_validation_error.dart';
import 'package:openapi/src/model/invitation.dart';
import 'package:openapi/src/model/invitation_get.dart';
import 'package:openapi/src/model/invoice_detail_get.dart';
import 'package:openapi/src/model/invoice_get.dart';
import 'package:openapi/src/model/location_inner.dart';
import 'package:openapi/src/model/member_get.dart';
import 'package:openapi/src/model/my_user.dart';
import 'package:openapi/src/model/notification.dart';
import 'package:openapi/src/model/permission_get.dart';
import 'package:openapi/src/model/permission_role_get.dart';
import 'package:openapi/src/model/registration.dart';
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
import 'package:openapi/src/model/u_activity_get.dart';
import 'package:openapi/src/model/user.dart';
import 'package:openapi/src/model/validation_error.dart';
import 'package:openapi/src/model/workspace_get.dart';
import 'package:openapi/src/model/workspace_upsert.dart';

part 'serializers.g.dart';

@SerializersFor([
  AccountGet,
  AccountOperationGet,
  AppSettingsGet,
  AuthToken,
  BodyAuthAppleToken,
  BodyAuthGoogleToken,
  BodyIapNotificationV1PaymentsIapNotificationPost,
  BodyRedeemV1MyInvitationsRedeemPost,
  BodyRegisterV1MyActivitiesRegisterPost,
  BodyRegistrationToken,
  BodyRequestRegistration,
  BodyRequestSourceType,
  BodyUpdateAccountV1MyAccountPost,
  BodyUpdatePushTokenV1MyPushTokensPost,
  ContractGet,
  EstimateUnitGet,
  EstimateValueGet,
  HTTPValidationError,
  Invitation,
  InvitationGet,
  InvoiceDetailGet,
  InvoiceGet,
  LocationInner,
  MemberGet,
  MyUser,
  Notification,
  PermissionGet,
  PermissionRoleGet,
  Registration,
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
  UActivityGet,
  User,
  ValidationError,
  WorkspaceGet,
  WorkspaceUpsert,
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
        const FullType(BuiltList, [FullType(InvitationGet)]),
        () => ListBuilder<InvitationGet>(),
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
