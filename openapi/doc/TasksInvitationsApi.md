# openapi.api.TasksInvitationsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createInvitation**](TasksInvitationsApi.md#createinvitation) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/invitations | Create
[**getInvitations**](TasksInvitationsApi.md#getinvitations) | **GET** /v1/workspaces/{ws_id}/tasks/{task_id}/invitations | Invitations


# **createInvitation**
> InvitationGet createInvitation(wsId, taskId, invitation, permissionTaskId)

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
final int taskId = 56; // int | 
final Invitation invitation = ; // Invitation | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.createInvitation(wsId, taskId, invitation, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksInvitationsApi->createInvitation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **invitation** | [**Invitation**](Invitation.md)|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

[**InvitationGet**](InvitationGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getInvitations**
> BuiltList<InvitationGet> getInvitations(taskId, wsId, roleId, permissionTaskId)

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
final int wsId = 56; // int | 
final int roleId = 56; // int | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.getInvitations(taskId, wsId, roleId, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksInvitationsApi->getInvitations: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **wsId** | **int**|  | 
 **roleId** | **int**|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;InvitationGet&gt;**](InvitationGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

