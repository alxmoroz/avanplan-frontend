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
import 'package:avanplan_api/src/date_serializer.dart';
import 'package:avanplan_api/src/model/date.dart';

import 'package:avanplan_api/src/model/app_settings_get.dart';
import 'package:avanplan_api/src/model/attachment_get.dart';
import 'package:avanplan_api/src/model/auth_token.dart';
import 'package:avanplan_api/src/model/body_auth_apple_token.dart';
import 'package:avanplan_api/src/model/body_auth_google_token.dart';
import 'package:avanplan_api/src/model/body_auth_yandex_token.dart';
import 'package:avanplan_api/src/model/body_iap_notification_v1_payments_iap_notification_post.dart';
import 'package:avanplan_api/src/model/body_my_calendar_sources_upsert.dart';
import 'package:avanplan_api/src/model/body_redeem_invitation.dart';
import 'package:avanplan_api/src/model/body_register_v1_my_activities_register_post.dart';
import 'package:avanplan_api/src/model/body_registration_token.dart';
import 'package:avanplan_api/src/model/body_request_registration.dart';
import 'package:avanplan_api/src/model/body_request_type.dart';
import 'package:avanplan_api/src/model/body_start_import.dart';
import 'package:avanplan_api/src/model/body_update_push_token_v1_my_push_tokens_post.dart';
import 'package:avanplan_api/src/model/calendar_event_attendee.dart';
import 'package:avanplan_api/src/model/calendar_event_get.dart';
import 'package:avanplan_api/src/model/calendar_get.dart';
import 'package:avanplan_api/src/model/calendar_source_get.dart';
import 'package:avanplan_api/src/model/calendars_events.dart';
import 'package:avanplan_api/src/model/contract_get.dart';
import 'package:avanplan_api/src/model/estimate_unit_get.dart';
import 'package:avanplan_api/src/model/estimate_value_get.dart';
import 'package:avanplan_api/src/model/http_validation_error.dart';
import 'package:avanplan_api/src/model/invitation.dart';
import 'package:avanplan_api/src/model/invitation_get.dart';
import 'package:avanplan_api/src/model/invoice_detail_get.dart';
import 'package:avanplan_api/src/model/invoice_get.dart';
import 'package:avanplan_api/src/model/member_contact_get.dart';
import 'package:avanplan_api/src/model/member_get.dart';
import 'package:avanplan_api/src/model/my_user.dart';
import 'package:avanplan_api/src/model/note_get.dart';
import 'package:avanplan_api/src/model/note_upsert.dart';
import 'package:avanplan_api/src/model/notification.dart';
import 'package:avanplan_api/src/model/permission_get.dart';
import 'package:avanplan_api/src/model/permission_role_get.dart';
import 'package:avanplan_api/src/model/project_get.dart';
import 'package:avanplan_api/src/model/project_status_get.dart';
import 'package:avanplan_api/src/model/project_status_upsert.dart';
import 'package:avanplan_api/src/model/promo_action_get.dart';
import 'package:avanplan_api/src/model/registration.dart';
import 'package:avanplan_api/src/model/release_note_get.dart';
import 'package:avanplan_api/src/model/role_get.dart';
import 'package:avanplan_api/src/model/settings_get.dart';
import 'package:avanplan_api/src/model/source_get.dart';
import 'package:avanplan_api/src/model/source_upsert.dart';
import 'package:avanplan_api/src/model/tariff_get.dart';
import 'package:avanplan_api/src/model/tariff_option_get.dart';
import 'package:avanplan_api/src/model/task_get.dart';
import 'package:avanplan_api/src/model/task_node.dart';
import 'package:avanplan_api/src/model/task_relation_get.dart';
import 'package:avanplan_api/src/model/task_relation_upsert.dart';
import 'package:avanplan_api/src/model/task_remote.dart';
import 'package:avanplan_api/src/model/task_repeat_get.dart';
import 'package:avanplan_api/src/model/task_repeat_upsert.dart';
import 'package:avanplan_api/src/model/task_settings_get.dart';
import 'package:avanplan_api/src/model/task_source.dart';
import 'package:avanplan_api/src/model/task_source_get.dart';
import 'package:avanplan_api/src/model/task_transaction_get.dart';
import 'package:avanplan_api/src/model/task_transaction_upsert.dart';
import 'package:avanplan_api/src/model/task_upsert.dart';
import 'package:avanplan_api/src/model/tasks_changes.dart';
import 'package:avanplan_api/src/model/u_activity_get.dart';
import 'package:avanplan_api/src/model/user.dart';
import 'package:avanplan_api/src/model/user_contact_get.dart';
import 'package:avanplan_api/src/model/user_contact_upsert.dart';
import 'package:avanplan_api/src/model/validation_error.dart';
import 'package:avanplan_api/src/model/validation_error_loc_inner.dart';
import 'package:avanplan_api/src/model/workspace_get.dart';
import 'package:avanplan_api/src/model/workspace_upsert.dart';

part 'serializers.g.dart';

@SerializersFor([
  AppSettingsGet,
  AttachmentGet,
  AuthToken,
  BodyAuthAppleToken,
  BodyAuthGoogleToken,
  BodyAuthYandexToken,
  BodyIapNotificationV1PaymentsIapNotificationPost,
  BodyMyCalendarSourcesUpsert,
  BodyRedeemInvitation,
  BodyRegisterV1MyActivitiesRegisterPost,
  BodyRegistrationToken,
  BodyRequestRegistration,
  BodyRequestType,
  BodyStartImport,
  BodyUpdatePushTokenV1MyPushTokensPost,
  CalendarEventAttendee,
  CalendarEventGet,
  CalendarGet,
  CalendarSourceGet,
  CalendarsEvents,
  ContractGet,
  EstimateUnitGet,
  EstimateValueGet,
  HTTPValidationError,
  Invitation,
  InvitationGet,
  InvoiceDetailGet,
  InvoiceGet,
  MemberContactGet,
  MemberGet,
  MyUser,
  NoteGet,
  NoteUpsert,
  Notification,
  PermissionGet,
  PermissionRoleGet,
  ProjectGet,
  ProjectStatusGet,
  ProjectStatusUpsert,
  PromoActionGet,
  Registration,
  ReleaseNoteGet,
  RoleGet,
  SettingsGet,
  SourceGet,
  SourceUpsert,
  TariffGet,
  TariffOptionGet,
  TaskGet,
  TaskNode,
  TaskRelationGet,
  TaskRelationUpsert,
  TaskRemote,
  TaskRepeatGet,
  TaskRepeatUpsert,
  TaskSettingsGet,
  TaskSource,
  TaskSourceGet,
  TaskTransactionGet,
  TaskTransactionUpsert,
  TaskUpsert,
  TasksChanges,
  UActivityGet,
  User,
  UserContactGet,
  UserContactUpsert,
  ValidationError,
  ValidationErrorLocInner,
  WorkspaceGet,
  WorkspaceUpsert,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Notification)]),
        () => ListBuilder<Notification>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(WorkspaceGet)]),
        () => ListBuilder<WorkspaceGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(UserContactGet)]),
        () => ListBuilder<UserContactGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TariffGet)]),
        () => ListBuilder<TariffGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(InvitationGet)]),
        () => ListBuilder<InvitationGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TaskRemote)]),
        () => ListBuilder<TaskRemote>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(MemberContactGet)]),
        () => ListBuilder<MemberContactGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ProjectGet)]),
        () => ListBuilder<ProjectGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(int)]),
        () => ListBuilder<int>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ReleaseNoteGet)]),
        () => ListBuilder<ReleaseNoteGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(CalendarSourceGet)]),
        () => ListBuilder<CalendarSourceGet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(MemberGet)]),
        () => ListBuilder<MemberGet>(),
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
