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
import 'package:openapi/src/api/contracts_api.dart';
import 'package:openapi/src/api/feature_sets_api.dart';
import 'package:openapi/src/api/integrations_sources_api.dart';
import 'package:openapi/src/api/integrations_tasks_api.dart';
import 'package:openapi/src/api/my_account_api.dart';
import 'package:openapi/src/api/my_activities_api.dart';
import 'package:openapi/src/api/my_invitations_api.dart';
import 'package:openapi/src/api/my_notifications_api.dart';
import 'package:openapi/src/api/my_projects_api.dart';
import 'package:openapi/src/api/my_push_tokens_api.dart';
import 'package:openapi/src/api/my_tasks_api.dart';
import 'package:openapi/src/api/payments_api.dart';
import 'package:openapi/src/api/project_feature_sets_api.dart';
import 'package:openapi/src/api/settings_api.dart';
import 'package:openapi/src/api/tariffs_api.dart';
import 'package:openapi/src/api/tasks_api.dart';
import 'package:openapi/src/api/tasks_invitations_api.dart';
import 'package:openapi/src/api/tasks_notes_api.dart';
import 'package:openapi/src/api/tasks_roles_api.dart';
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

  /// Get ContractsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ContractsApi getContractsApi() {
    return ContractsApi(dio, serializers);
  }

  /// Get FeatureSetsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  FeatureSetsApi getFeatureSetsApi() {
    return FeatureSetsApi(dio, serializers);
  }

  /// Get IntegrationsSourcesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  IntegrationsSourcesApi getIntegrationsSourcesApi() {
    return IntegrationsSourcesApi(dio, serializers);
  }

  /// Get IntegrationsTasksApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  IntegrationsTasksApi getIntegrationsTasksApi() {
    return IntegrationsTasksApi(dio, serializers);
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

  /// Get MyProjectsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MyProjectsApi getMyProjectsApi() {
    return MyProjectsApi(dio, serializers);
  }

  /// Get MyPushTokensApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MyPushTokensApi getMyPushTokensApi() {
    return MyPushTokensApi(dio, serializers);
  }

  /// Get MyTasksApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MyTasksApi getMyTasksApi() {
    return MyTasksApi(dio, serializers);
  }

  /// Get PaymentsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PaymentsApi getPaymentsApi() {
    return PaymentsApi(dio, serializers);
  }

  /// Get ProjectFeatureSetsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ProjectFeatureSetsApi getProjectFeatureSetsApi() {
    return ProjectFeatureSetsApi(dio, serializers);
  }

  /// Get SettingsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SettingsApi getSettingsApi() {
    return SettingsApi(dio, serializers);
  }

  /// Get TariffsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TariffsApi getTariffsApi() {
    return TariffsApi(dio, serializers);
  }

  /// Get TasksApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TasksApi getTasksApi() {
    return TasksApi(dio, serializers);
  }

  /// Get TasksInvitationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TasksInvitationsApi getTasksInvitationsApi() {
    return TasksInvitationsApi(dio, serializers);
  }

  /// Get TasksNotesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TasksNotesApi getTasksNotesApi() {
    return TasksNotesApi(dio, serializers);
  }

  /// Get TasksRolesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TasksRolesApi getTasksRolesApi() {
    return TasksRolesApi(dio, serializers);
  }

  /// Get WorkspacesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WorkspacesApi getWorkspacesApi() {
    return WorkspacesApi(dio, serializers);
  }
}
