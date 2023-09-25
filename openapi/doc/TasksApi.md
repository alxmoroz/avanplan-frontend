# openapi.api.TasksApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**assignV1TasksRolesPost**](TasksApi.md#assignv1tasksrolespost) | **POST** /v1/tasks/roles | Assign
[**createV1TasksInvitationsPost**](TasksApi.md#createv1tasksinvitationspost) | **POST** /v1/tasks/invitations | Create
[**deleteV1TasksNotesNoteIdDelete**](TasksApi.md#deletev1tasksnotesnoteiddelete) | **DELETE** /v1/tasks/notes/{note_id} | Delete
[**deleteV1TasksTaskIdDelete**](TasksApi.md#deletev1taskstaskiddelete) | **DELETE** /v1/tasks/{task_id} | Delete
[**invitationsV1TasksInvitationsGet**](TasksApi.md#invitationsv1tasksinvitationsget) | **GET** /v1/tasks/invitations | Invitations
[**setupFeatureSetsV1TasksFeatureSetsPost**](TasksApi.md#setupfeaturesetsv1tasksfeaturesetspost) | **POST** /v1/tasks/feature_sets | Setup Feature Sets
[**taskUpsertV1TasksPost**](TasksApi.md#taskupsertv1taskspost) | **POST** /v1/tasks | Task Upsert
[**upsertV1TasksNotesPost**](TasksApi.md#upsertv1tasksnotespost) | **POST** /v1/tasks/notes | Upsert


# **assignV1TasksRolesPost**
> BuiltList<MemberGet> assignV1TasksRolesPost(taskId, memberId, wsId, requestBody, permissionTaskId)

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
final int memberId = 56; // int | 
final int wsId = 56; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.assignV1TasksRolesPost(taskId, memberId, wsId, requestBody, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->assignV1TasksRolesPost: $e\n');
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

final api = Openapi().getTasksApi();
final int wsId = 56; // int | 
final Invitation invitation = ; // Invitation | 

try {
    final response = api.createV1TasksInvitationsPost(wsId, invitation);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->createV1TasksInvitationsPost: $e\n');
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

# **deleteV1TasksNotesNoteIdDelete**
> bool deleteV1TasksNotesNoteIdDelete(noteId, wsId, permissionTaskId)

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
final int permissionTaskId = 56; // int | 

try {
    final response = api.deleteV1TasksNotesNoteIdDelete(noteId, wsId, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->deleteV1TasksNotesNoteIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **noteId** | **int**|  | 
 **wsId** | **int**|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteV1TasksTaskIdDelete**
> TasksChanges deleteV1TasksTaskIdDelete(taskId, wsId, permissionTaskId)

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
    final response = api.deleteV1TasksTaskIdDelete(taskId, wsId, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->deleteV1TasksTaskIdDelete: $e\n');
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

final api = Openapi().getTasksApi();
final int taskId = 56; // int | 
final int roleId = 56; // int | 
final int wsId = 56; // int | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.invitationsV1TasksInvitationsGet(taskId, roleId, wsId, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->invitationsV1TasksInvitationsGet: $e\n');
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

# **setupFeatureSetsV1TasksFeatureSetsPost**
> BuiltList<ProjectFeatureSetGet> setupFeatureSetsV1TasksFeatureSetsPost(projectId, wsId, requestBody, permissionTaskId)

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
final int projectId = 56; // int | 
final int wsId = 56; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.setupFeatureSetsV1TasksFeatureSetsPost(projectId, wsId, requestBody, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->setupFeatureSetsV1TasksFeatureSetsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **projectId** | **int**|  | 
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

# **taskUpsertV1TasksPost**
> TasksChanges taskUpsertV1TasksPost(wsId, taskUpsert, permissionTaskId)

Task Upsert

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

try {
    final response = api.taskUpsertV1TasksPost(wsId, taskUpsert, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->taskUpsertV1TasksPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskUpsert** | [**TaskUpsert**](TaskUpsert.md)|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

[**TasksChanges**](TasksChanges.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertV1TasksNotesPost**
> NoteGet upsertV1TasksNotesPost(wsId, noteUpsert, permissionTaskId)

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
final NoteUpsert noteUpsert = ; // NoteUpsert | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.upsertV1TasksNotesPost(wsId, noteUpsert, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksApi->upsertV1TasksNotesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
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

