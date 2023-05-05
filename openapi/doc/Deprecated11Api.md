# openapi.api.Deprecated11Api

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deprecatedCreateWorkspaceV1MyCreateWorkspacePost**](Deprecated11Api.md#deprecatedcreateworkspacev1mycreateworkspacepost) | **POST** /v1/my/create_workspace | Deprecated Create Workspace
[**deprecatedInvitationCreateV1InvitationPost**](Deprecated11Api.md#deprecatedinvitationcreatev1invitationpost) | **POST** /v1/invitation | Deprecated Invitation Create
[**deprecatedRedeemInvitationV1MyRedeemInvitationPost**](Deprecated11Api.md#deprecatedredeeminvitationv1myredeeminvitationpost) | **POST** /v1/my/redeem_invitation | Deprecated Redeem Invitation
[**deprecatedRolesAssignV1RolesPost**](Deprecated11Api.md#deprecatedrolesassignv1rolespost) | **POST** /v1/roles | Deprecated Roles Assign
[**deprecatedUpdatePushTokenV1MyPushTokenPost**](Deprecated11Api.md#deprecatedupdatepushtokenv1mypushtokenpost) | **POST** /v1/my/push_token | Deprecated Update Push Token
[**deprecatedUpdateWorkspaceV1MyUpdateWorkspacePost**](Deprecated11Api.md#deprecatedupdateworkspacev1myupdateworkspacepost) | **POST** /v1/my/update_workspace | Deprecated Update Workspace


# **deprecatedCreateWorkspaceV1MyCreateWorkspacePost**
> WorkspaceGet deprecatedCreateWorkspaceV1MyCreateWorkspacePost(workspaceUpsert)

Deprecated Create Workspace

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getDeprecated11Api();
final WorkspaceUpsert workspaceUpsert = ; // WorkspaceUpsert | 

try {
    final response = api.deprecatedCreateWorkspaceV1MyCreateWorkspacePost(workspaceUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling Deprecated11Api->deprecatedCreateWorkspaceV1MyCreateWorkspacePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **workspaceUpsert** | [**WorkspaceUpsert**](WorkspaceUpsert.md)|  | [optional] 

### Return type

[**WorkspaceGet**](WorkspaceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deprecatedInvitationCreateV1InvitationPost**
> String deprecatedInvitationCreateV1InvitationPost(wsId, invitation)

Deprecated Invitation Create

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getDeprecated11Api();
final int wsId = 56; // int | 
final Invitation invitation = ; // Invitation | 

try {
    final response = api.deprecatedInvitationCreateV1InvitationPost(wsId, invitation);
    print(response);
} catch on DioError (e) {
    print('Exception when calling Deprecated11Api->deprecatedInvitationCreateV1InvitationPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **invitation** | [**Invitation**](Invitation.md)|  | 

### Return type

**String**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deprecatedRedeemInvitationV1MyRedeemInvitationPost**
> bool deprecatedRedeemInvitationV1MyRedeemInvitationPost(bodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost)

Deprecated Redeem Invitation

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getDeprecated11Api();
final BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost bodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost = ; // BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost | 

try {
    final response = api.deprecatedRedeemInvitationV1MyRedeemInvitationPost(bodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost);
    print(response);
} catch on DioError (e) {
    print('Exception when calling Deprecated11Api->deprecatedRedeemInvitationV1MyRedeemInvitationPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost** | [**BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost**](BodyDeprecatedRedeemInvitationV1MyRedeemInvitationPost.md)|  | [optional] 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deprecatedRolesAssignV1RolesPost**
> BuiltList<MemberGet> deprecatedRolesAssignV1RolesPost(taskId, memberId, wsId, requestBody, permissionTaskId)

Deprecated Roles Assign

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getDeprecated11Api();
final int taskId = 56; // int | 
final int memberId = 56; // int | 
final int wsId = 56; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.deprecatedRolesAssignV1RolesPost(taskId, memberId, wsId, requestBody, permissionTaskId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling Deprecated11Api->deprecatedRolesAssignV1RolesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **memberId** | **int**|  | 
 **wsId** | **int**|  | 
 **requestBody** | [**BuiltList&lt;int&gt;**](int.md)|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;MemberGet&gt;**](MemberGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deprecatedUpdatePushTokenV1MyPushTokenPost**
> bool deprecatedUpdatePushTokenV1MyPushTokenPost(bodyDeprecatedUpdatePushTokenV1MyPushTokenPost)

Deprecated Update Push Token

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getDeprecated11Api();
final BodyDeprecatedUpdatePushTokenV1MyPushTokenPost bodyDeprecatedUpdatePushTokenV1MyPushTokenPost = ; // BodyDeprecatedUpdatePushTokenV1MyPushTokenPost | 

try {
    final response = api.deprecatedUpdatePushTokenV1MyPushTokenPost(bodyDeprecatedUpdatePushTokenV1MyPushTokenPost);
    print(response);
} catch on DioError (e) {
    print('Exception when calling Deprecated11Api->deprecatedUpdatePushTokenV1MyPushTokenPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyDeprecatedUpdatePushTokenV1MyPushTokenPost** | [**BodyDeprecatedUpdatePushTokenV1MyPushTokenPost**](BodyDeprecatedUpdatePushTokenV1MyPushTokenPost.md)|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deprecatedUpdateWorkspaceV1MyUpdateWorkspacePost**
> WorkspaceGet deprecatedUpdateWorkspaceV1MyUpdateWorkspacePost(wsId, workspaceUpsert)

Deprecated Update Workspace

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getDeprecated11Api();
final int wsId = 56; // int | 
final WorkspaceUpsert workspaceUpsert = ; // WorkspaceUpsert | 

try {
    final response = api.deprecatedUpdateWorkspaceV1MyUpdateWorkspacePost(wsId, workspaceUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling Deprecated11Api->deprecatedUpdateWorkspaceV1MyUpdateWorkspacePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **workspaceUpsert** | [**WorkspaceUpsert**](WorkspaceUpsert.md)|  | 

### Return type

[**WorkspaceGet**](WorkspaceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

