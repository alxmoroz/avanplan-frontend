//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:openapi/src/serializers.dart';
import 'package:openapi/src/auth/api_key_auth.dart';
import 'package:openapi/src/auth/basic_auth.dart';
import 'package:openapi/src/auth/bearer_auth.dart';
import 'package:openapi/src/auth/oauth.dart';
import 'package:openapi/src/api/auth_api.dart';
import 'package:openapi/src/api/my_account_api.dart';
import 'package:openapi/src/api/my_activities_api.dart';
import 'package:openapi/src/api/my_avatar_api.dart';
import 'package:openapi/src/api/my_calendar_api.dart';
import 'package:openapi/src/api/my_contacts_api.dart';
import 'package:openapi/src/api/my_invitations_api.dart';
import 'package:openapi/src/api/my_notifications_api.dart';
import 'package:openapi/src/api/my_push_tokens_api.dart';
import 'package:openapi/src/api/payments_api.dart';
import 'package:openapi/src/api/project_members_api.dart';
import 'package:openapi/src/api/project_modules_api.dart';
import 'package:openapi/src/api/project_statuses_api.dart';
import 'package:openapi/src/api/release_notes_api.dart';
import 'package:openapi/src/api/settings_api.dart';
import 'package:openapi/src/api/task_invitations_api.dart';
import 'package:openapi/src/api/task_notes_api.dart';
import 'package:openapi/src/api/task_repeats_api.dart';
import 'package:openapi/src/api/task_transactions_api.dart';
import 'package:openapi/src/api/wsmy_api.dart';
import 'package:openapi/src/api/ws_relations_api.dart';
import 'package:openapi/src/api/ws_sources_api.dart';
import 'package:openapi/src/api/ws_tariff_options_api.dart';
import 'package:openapi/src/api/ws_tariffs_api.dart';
import 'package:openapi/src/api/ws_tasks_api.dart';
import 'package:openapi/src/api/ws_transfer_api.dart';
import 'package:openapi/src/api/workspaces_api.dart';

class Openapi {
  static const String basePath = r'/api';

  final Dio dio;
  final Serializers serializers;

  Openapi({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor) as OAuthInterceptor).tokens[name] = token;
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor) as BearerAuthInterceptor).tokens[name] = token;
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor) as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }
  }

  /// Get AuthApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AuthApi getAuthApi() {
    return AuthApi(dio, serializers);
  }

  /// Get MyAccountApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MyAccountApi getMyAccountApi() {
    return MyAccountApi(dio, serializers);
  }

  /// Get MyActivitiesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MyActivitiesApi getMyActivitiesApi() {
    return MyActivitiesApi(dio, serializers);
  }

  /// Get MyAvatarApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MyAvatarApi getMyAvatarApi() {
    return MyAvatarApi(dio, serializers);
  }

  /// Get MyCalendarApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MyCalendarApi getMyCalendarApi() {
    return MyCalendarApi(dio, serializers);
  }

  /// Get MyContactsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MyContactsApi getMyContactsApi() {
    return MyContactsApi(dio, serializers);
  }

  /// Get MyInvitationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MyInvitationsApi getMyInvitationsApi() {
    return MyInvitationsApi(dio, serializers);
  }

  /// Get MyNotificationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MyNotificationsApi getMyNotificationsApi() {
    return MyNotificationsApi(dio, serializers);
  }

  /// Get MyPushTokensApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MyPushTokensApi getMyPushTokensApi() {
    return MyPushTokensApi(dio, serializers);
  }

  /// Get PaymentsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PaymentsApi getPaymentsApi() {
    return PaymentsApi(dio, serializers);
  }

  /// Get ProjectMembersApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ProjectMembersApi getProjectMembersApi() {
    return ProjectMembersApi(dio, serializers);
  }

  /// Get ProjectModulesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ProjectModulesApi getProjectModulesApi() {
    return ProjectModulesApi(dio, serializers);
  }

  /// Get ProjectStatusesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ProjectStatusesApi getProjectStatusesApi() {
    return ProjectStatusesApi(dio, serializers);
  }

  /// Get ReleaseNotesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ReleaseNotesApi getReleaseNotesApi() {
    return ReleaseNotesApi(dio, serializers);
  }

  /// Get SettingsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SettingsApi getSettingsApi() {
    return SettingsApi(dio, serializers);
  }

  /// Get TaskInvitationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TaskInvitationsApi getTaskInvitationsApi() {
    return TaskInvitationsApi(dio, serializers);
  }

  /// Get TaskNotesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TaskNotesApi getTaskNotesApi() {
    return TaskNotesApi(dio, serializers);
  }

  /// Get TaskRepeatsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TaskRepeatsApi getTaskRepeatsApi() {
    return TaskRepeatsApi(dio, serializers);
  }

  /// Get TaskTransactionsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TaskTransactionsApi getTaskTransactionsApi() {
    return TaskTransactionsApi(dio, serializers);
  }

  /// Get WSMyApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WSMyApi getWSMyApi() {
    return WSMyApi(dio, serializers);
  }

  /// Get WSRelationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WSRelationsApi getWSRelationsApi() {
    return WSRelationsApi(dio, serializers);
  }

  /// Get WSSourcesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WSSourcesApi getWSSourcesApi() {
    return WSSourcesApi(dio, serializers);
  }

  /// Get WSTariffOptionsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WSTariffOptionsApi getWSTariffOptionsApi() {
    return WSTariffOptionsApi(dio, serializers);
  }

  /// Get WSTariffsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WSTariffsApi getWSTariffsApi() {
    return WSTariffsApi(dio, serializers);
  }

  /// Get WSTasksApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WSTasksApi getWSTasksApi() {
    return WSTasksApi(dio, serializers);
  }

  /// Get WSTransferApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WSTransferApi getWSTransferApi() {
    return WSTransferApi(dio, serializers);
  }

  /// Get WorkspacesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WorkspacesApi getWorkspacesApi() {
    return WorkspacesApi(dio, serializers);
  }
}
