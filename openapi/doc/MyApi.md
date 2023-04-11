# openapi.api.MyApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accountV1MyAccountGet**](MyApi.md#accountv1myaccountget) | **GET** /v1/my/account | Account
[**deleteAccountV1MyAccountDelete**](MyApi.md#deleteaccountv1myaccountdelete) | **DELETE** /v1/my/account | Delete Account
[**markReadNotificationsV1MyNotificationsPost**](MyApi.md#markreadnotificationsv1mynotificationspost) | **POST** /v1/my/notifications | Mark Read Notifications
[**notificationsV1MyNotificationsGet**](MyApi.md#notificationsv1mynotificationsget) | **GET** /v1/my/notifications | Notifications
[**redeemInvitationV1MyRedeemInvitationPost**](MyApi.md#redeeminvitationv1myredeeminvitationpost) | **POST** /v1/my/redeem_invitation | Redeem Invitation
[**updateAccountV1MyAccountPost**](MyApi.md#updateaccountv1myaccountpost) | **POST** /v1/my/account | Update Account
[**updatePushTokenV1MyPushTokenPost**](MyApi.md#updatepushtokenv1mypushtokenpost) | **POST** /v1/my/push_token | Update Push Token
[**workspacesV1MyWorkspacesGet**](MyApi.md#workspacesv1myworkspacesget) | **GET** /v1/my/workspaces | Workspaces


# **accountV1MyAccountGet**
> User accountV1MyAccountGet()

Account

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();

try {
    final response = api.accountV1MyAccountGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->accountV1MyAccountGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**User**](User.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteAccountV1MyAccountDelete**
> bool deleteAccountV1MyAccountDelete()

Delete Account

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();

try {
    final response = api.deleteAccountV1MyAccountDelete();
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->deleteAccountV1MyAccountDelete: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markReadNotificationsV1MyNotificationsPost**
> bool markReadNotificationsV1MyNotificationsPost(requestBody)

Mark Read Notifications

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();
final BuiltList<int> requestBody = ; // BuiltList<int> | 

try {
    final response = api.markReadNotificationsV1MyNotificationsPost(requestBody);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->markReadNotificationsV1MyNotificationsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestBody** | [**BuiltList&lt;int&gt;**](int.md)|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationsV1MyNotificationsGet**
> BuiltList<Notification> notificationsV1MyNotificationsGet()

Notifications

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();

try {
    final response = api.notificationsV1MyNotificationsGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->notificationsV1MyNotificationsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Notification&gt;**](Notification.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **redeemInvitationV1MyRedeemInvitationPost**
> bool redeemInvitationV1MyRedeemInvitationPost(bodyRedeemInvitationV1MyRedeemInvitationPost)

Redeem Invitation

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();
final BodyRedeemInvitationV1MyRedeemInvitationPost bodyRedeemInvitationV1MyRedeemInvitationPost = ; // BodyRedeemInvitationV1MyRedeemInvitationPost | 

try {
    final response = api.redeemInvitationV1MyRedeemInvitationPost(bodyRedeemInvitationV1MyRedeemInvitationPost);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->redeemInvitationV1MyRedeemInvitationPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyRedeemInvitationV1MyRedeemInvitationPost** | [**BodyRedeemInvitationV1MyRedeemInvitationPost**](BodyRedeemInvitationV1MyRedeemInvitationPost.md)|  | [optional] 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateAccountV1MyAccountPost**
> User updateAccountV1MyAccountPost(bodyUpdateAccountV1MyAccountPost)

Update Account

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();
final BodyUpdateAccountV1MyAccountPost bodyUpdateAccountV1MyAccountPost = ; // BodyUpdateAccountV1MyAccountPost | 

try {
    final response = api.updateAccountV1MyAccountPost(bodyUpdateAccountV1MyAccountPost);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->updateAccountV1MyAccountPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyUpdateAccountV1MyAccountPost** | [**BodyUpdateAccountV1MyAccountPost**](BodyUpdateAccountV1MyAccountPost.md)|  | [optional] 

### Return type

[**User**](User.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePushTokenV1MyPushTokenPost**
> bool updatePushTokenV1MyPushTokenPost(bodyUpdatePushTokenV1MyPushTokenPost)

Update Push Token

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();
final BodyUpdatePushTokenV1MyPushTokenPost bodyUpdatePushTokenV1MyPushTokenPost = ; // BodyUpdatePushTokenV1MyPushTokenPost | 

try {
    final response = api.updatePushTokenV1MyPushTokenPost(bodyUpdatePushTokenV1MyPushTokenPost);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->updatePushTokenV1MyPushTokenPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyUpdatePushTokenV1MyPushTokenPost** | [**BodyUpdatePushTokenV1MyPushTokenPost**](BodyUpdatePushTokenV1MyPushTokenPost.md)|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **workspacesV1MyWorkspacesGet**
> BuiltList<WorkspaceGet> workspacesV1MyWorkspacesGet()

Workspaces

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();

try {
    final response = api.workspacesV1MyWorkspacesGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->workspacesV1MyWorkspacesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;WorkspaceGet&gt;**](WorkspaceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

