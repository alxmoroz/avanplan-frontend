# openapi.api.TasksApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**assignRole**](TasksApi.md#assignrole) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/roles | Assign
[**createInvitation**](TasksApi.md#createinvitation) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/invitations | Create
[**deleteNote**](TasksApi.md#deletenote) | **DELETE** /v1/workspaces/{ws_id}/tasks/{task_id}/notes/{note_id} | Delete
[**deleteStatus**](TasksApi.md#deletestatus) | **DELETE** /v1/workspaces/{ws_id}/tasks/{task_id}/statuses/{status_id} | Delete
[**deleteTask**](TasksApi.md#deletetask) | **DELETE** /v1/workspaces/{ws_id}/tasks/{task_id} | Delete
[**getInvitations**](TasksApi.md#getinvitations) | **GET** /v1/workspaces/{ws_id}/tasks/{task_id}/invitations | Invitations
[**setupFeatureSets**](TasksApi.md#setupfeaturesets) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/feature_sets | Setup Feature Sets
[**upsertNote**](TasksApi.md#upsertnote) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/notes | Upsert
[**upsertStatus**](TasksApi.md#upsertstatus) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/statuses | Upsert
[**upsertTask**](TasksApi.md#upserttask) | **POST** /v1/workspaces/{ws_id}/tasks | Upsert Task


# **assignRole**
> BuiltList<MemberGet> assignRole(taskId, wsId, memberId, requestBody, permissionTaskId)

Assign

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int taskId = 56; // int | 
final int wsId = 56; // int | 
final int memberId = 56; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.assignRole(taskId, wsId, memberId, requestBody, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->assignRole: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **wsId** | **int**|  | 
 **memberId** | **int**|  | 
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

final api = Openapi().getTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final Invitation invitation = ; // Invitation | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.createInvitation(wsId, taskId, invitation, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->createInvitation: $e\n');
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

# **deleteNote**
> bool deleteNote(noteId, wsId, taskId, permissionTaskId)

Delete

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int noteId = 56; // int | 
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.deleteNote(noteId, wsId, taskId, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->deleteNote: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **noteId** | **int**|  | 
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteStatus**
> bool deleteStatus(statusId, wsId, taskId, permissionTaskId)

Delete

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int statusId = 56; // int | 
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.deleteStatus(statusId, wsId, taskId, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->deleteStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **statusId** | **int**|  | 
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTask**
> TasksChanges deleteTask(taskId, wsId, permissionTaskId)

Delete

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int taskId = 56; // int | 
final int wsId = 56; // int | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.deleteTask(taskId, wsId, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->deleteTask: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **wsId** | **int**|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

[**TasksChanges**](TasksChanges.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
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

final api = Openapi().getTasksApi();
final int taskId = 56; // int | 
final int wsId = 56; // int | 
final int roleId = 56; // int | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.getInvitations(taskId, wsId, roleId, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->getInvitations: $e\n');
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

# **setupFeatureSets**
> BuiltList<ProjectFeatureSetGet> setupFeatureSets(taskId, wsId, requestBody, permissionTaskId)

Setup Feature Sets

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int taskId = 56; // int | 
final int wsId = 56; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.setupFeatureSets(taskId, wsId, requestBody, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->setupFeatureSets: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **wsId** | **int**|  | 
 **requestBody** | [**BuiltList&lt;int&gt;**](int.md)|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;ProjectFeatureSetGet&gt;**](ProjectFeatureSetGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertNote**
> NoteGet upsertNote(wsId, taskId, noteUpsert, permissionTaskId)

Upsert

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final NoteUpsert noteUpsert = ; // NoteUpsert | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.upsertNote(wsId, taskId, noteUpsert, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->upsertNote: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **noteUpsert** | [**NoteUpsert**](NoteUpsert.md)|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

[**NoteGet**](NoteGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertStatus**
> ProjectStatusGet upsertStatus(wsId, taskId, projectStatusUpsert, permissionTaskId)

Upsert

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final ProjectStatusUpsert projectStatusUpsert = ; // ProjectStatusUpsert | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.upsertStatus(wsId, taskId, projectStatusUpsert, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->upsertStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **projectStatusUpsert** | [**ProjectStatusUpsert**](ProjectStatusUpsert.md)|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

[**ProjectStatusGet**](ProjectStatusGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertTask**
> TasksChanges upsertTask(wsId, taskUpsert, permissionTaskId, taskId)

Upsert Task

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int wsId = 56; // int | 
final TaskUpsert taskUpsert = ; // TaskUpsert | 
final int permissionTaskId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.upsertTask(wsId, taskUpsert, permissionTaskId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->upsertTask: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskUpsert** | [**TaskUpsert**](TaskUpsert.md)|  | 
 **permissionTaskId** | **int**|  | [optional] 
 **taskId** | **int**|  | [optional] 

### Return type

[**TasksChanges**](TasksChanges.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

