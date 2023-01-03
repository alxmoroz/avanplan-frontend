# openapi.api.MyApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteMyAccountV1MyAccountDelete**](MyApi.md#deletemyaccountv1myaccountdelete) | **DELETE** /v1/my/account | Delete My Account
[**deleteMyMessagesV1MyMessagesDelete**](MyApi.md#deletemymessagesv1mymessagesdelete) | **DELETE** /v1/my/messages | Delete My Messages
[**getMyAccountV1MyAccountGet**](MyApi.md#getmyaccountv1myaccountget) | **GET** /v1/my/account | Get My Account
[**getMyMessagesV1MyMessagesGet**](MyApi.md#getmymessagesv1mymessagesget) | **GET** /v1/my/messages | Get My Messages
[**getMyWorkspacesV1MyWorkspacesGet**](MyApi.md#getmyworkspacesv1myworkspacesget) | **GET** /v1/my/workspaces | Get My Workspaces
[**updateMyAccountV1MyAccountPost**](MyApi.md#updatemyaccountv1myaccountpost) | **POST** /v1/my/account | Update My Account
[**updateMyMessagesV1MyMessagesPost**](MyApi.md#updatemymessagesv1mymessagespost) | **POST** /v1/my/messages | Update My Messages


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

# **deleteMyMessagesV1MyMessagesDelete**
> JsonObject deleteMyMessagesV1MyMessagesDelete(requestBody)

Delete My Messages

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();
final BuiltList<int> requestBody = ; // BuiltList<int> | 

try {
    final response = api.deleteMyMessagesV1MyMessagesDelete(requestBody);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->deleteMyMessagesV1MyMessagesDelete: $e\n');
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

# **getMyAccountV1MyAccountGet**
> UserGet getMyAccountV1MyAccountGet()

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

[**UserGet**](UserGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyMessagesV1MyMessagesGet**
> BuiltList<EventMessageGet> getMyMessagesV1MyMessagesGet()

Get My Messages

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();

try {
    final response = api.getMyMessagesV1MyMessagesGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->getMyMessagesV1MyMessagesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;EventMessageGet&gt;**](EventMessageGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyWorkspacesV1MyWorkspacesGet**
> BuiltList<WSUserRoleGet> getMyWorkspacesV1MyWorkspacesGet()

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

[**BuiltList&lt;WSUserRoleGet&gt;**](WSUserRoleGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyAccountV1MyAccountPost**
> UserGet updateMyAccountV1MyAccountPost(bodyUpdateMyAccountV1MyAccountPost)

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

[**UserGet**](UserGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyMessagesV1MyMessagesPost**
> JsonObject updateMyMessagesV1MyMessagesPost(eventMessageUpsert)

Update My Messages

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyApi();
final BuiltList<EventMessageUpsert> eventMessageUpsert = ; // BuiltList<EventMessageUpsert> | 

try {
    final response = api.updateMyMessagesV1MyMessagesPost(eventMessageUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyApi->updateMyMessagesV1MyMessagesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **eventMessageUpsert** | [**BuiltList&lt;EventMessageUpsert&gt;**](EventMessageUpsert.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

