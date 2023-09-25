# openapi.api.TasksInvitationsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createV1TasksInvitationsPost**](TasksInvitationsApi.md#createv1tasksinvitationspost) | **POST** /v1/tasks/invitations | Create
[**invitationsV1TasksInvitationsGet**](TasksInvitationsApi.md#invitationsv1tasksinvitationsget) | **GET** /v1/tasks/invitations | Invitations


# **createV1TasksInvitationsPost**
> InvitationGet createV1TasksInvitationsPost(wsId, invitation)

Create

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksInvitationsApi();
final int wsId = 56; // int | 
final Invitation invitation = ; // Invitation | 

try {
    final response = api.createV1TasksInvitationsPost(wsId, invitation);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksInvitationsApi->createV1TasksInvitationsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **invitation** | [**Invitation**](Invitation.md)|  | 

### Return type

[**InvitationGet**](InvitationGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **invitationsV1TasksInvitationsGet**
> BuiltList<InvitationGet> invitationsV1TasksInvitationsGet(taskId, roleId, wsId, permissionTaskId)

Invitations

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksInvitationsApi();
final int taskId = 56; // int | 
final int roleId = 56; // int | 
final int wsId = 56; // int | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.invitationsV1TasksInvitationsGet(taskId, roleId, wsId, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksInvitationsApi->invitationsV1TasksInvitationsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **roleId** | **int**|  | 
 **wsId** | **int**|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;InvitationGet&gt;**](InvitationGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

