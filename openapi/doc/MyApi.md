# openapi.api.MyApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteMyAccountV1MyAccountDelete**](MyApi.md#deletemyaccountv1myaccountdelete) | **DELETE** /v1/my/account | Delete My Account
[**getMyAccountV1MyAccountGet**](MyApi.md#getmyaccountv1myaccountget) | **GET** /v1/my/account | Get My Account
[**getMyNotificationsV1MyNotificationsGet**](MyApi.md#getmynotificationsv1mynotificationsget) | **GET** /v1/my/notifications | Get My Notifications
[**getMyWorkspacesV1MyWorkspacesGet**](MyApi.md#getmyworkspacesv1myworkspacesget) | **GET** /v1/my/workspaces | Get My Workspaces
[**readMyMessagesV1MyMessagesPost**](MyApi.md#readmymessagesv1mymessagespost) | **POST** /v1/my/messages | Read My Messages
[**updateMyAccountV1MyAccountPost**](MyApi.md#updatemyaccountv1myaccountpost) | **POST** /v1/my/account | Update My Account
[**updatePushTokenV1MyPushTokenPost**](MyApi.md#updatepushtokenv1mypushtokenpost) | **POST** /v1/my/push_token | Update Push Token


# **deleteMyAccountV1MyAccountDelete**
> JsonObject deleteMyAccountV1MyAccountDelete()

Delete My Account

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();

try {
    final response = api.deleteMyAccountV1MyAccountDelete();
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->deleteMyAccountV1MyAccountDelete: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyAccountV1MyAccountGet**
> User getMyAccountV1MyAccountGet()

Get My Account

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();

try {
    final response = api.getMyAccountV1MyAccountGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->getMyAccountV1MyAccountGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**User**](User.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyNotificationsV1MyNotificationsGet**
> BuiltList<Notification> getMyNotificationsV1MyNotificationsGet()

Get My Notifications

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();

try {
    final response = api.getMyNotificationsV1MyNotificationsGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->getMyNotificationsV1MyNotificationsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Notification&gt;**](Notification.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyWorkspacesV1MyWorkspacesGet**
> BuiltList<WSUserRole> getMyWorkspacesV1MyWorkspacesGet()

Get My Workspaces

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();

try {
    final response = api.getMyWorkspacesV1MyWorkspacesGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->getMyWorkspacesV1MyWorkspacesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;WSUserRole&gt;**](WSUserRole.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **readMyMessagesV1MyMessagesPost**
> JsonObject readMyMessagesV1MyMessagesPost(requestBody)

Read My Messages

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();
final BuiltList<int> requestBody = ; // BuiltList<int> | 

try {
    final response = api.readMyMessagesV1MyMessagesPost(requestBody);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->readMyMessagesV1MyMessagesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestBody** | [**BuiltList&lt;int&gt;**](int.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyAccountV1MyAccountPost**
> User updateMyAccountV1MyAccountPost(bodyUpdateMyAccountV1MyAccountPost)

Update My Account

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();
final BodyUpdateMyAccountV1MyAccountPost bodyUpdateMyAccountV1MyAccountPost = ; // BodyUpdateMyAccountV1MyAccountPost | 

try {
    final response = api.updateMyAccountV1MyAccountPost(bodyUpdateMyAccountV1MyAccountPost);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->updateMyAccountV1MyAccountPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyUpdateMyAccountV1MyAccountPost** | [**BodyUpdateMyAccountV1MyAccountPost**](BodyUpdateMyAccountV1MyAccountPost.md)|  | [optional] 

### Return type

[**User**](User.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePushTokenV1MyPushTokenPost**
> JsonObject updatePushTokenV1MyPushTokenPost(bodyUpdatePushTokenV1MyPushTokenPost)

Update Push Token

### Example
```dart
import 'package:openapi/api.dart';
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

[**JsonObject**](JsonObject.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

