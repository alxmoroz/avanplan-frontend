# openapi.api.TasksNotesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteV1TasksNotesNoteIdDelete**](TasksNotesApi.md#deletev1tasksnotesnoteiddelete) | **DELETE** /v1/tasks/notes/{note_id} | Delete
[**upsertV1TasksNotesPost**](TasksNotesApi.md#upsertv1tasksnotespost) | **POST** /v1/tasks/notes | Upsert


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

final api = Openapi().getTasksNotesApi();
final int noteId = 56; // int | 
final int wsId = 56; // int | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.deleteV1TasksNotesNoteIdDelete(noteId, wsId, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksNotesApi->deleteV1TasksNotesNoteIdDelete: $e\n');
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

final api = Openapi().getTasksNotesApi();
final int wsId = 56; // int | 
final NoteUpsert noteUpsert = ; // NoteUpsert | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.upsertV1TasksNotesPost(wsId, noteUpsert, permissionTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TasksNotesApi->upsertV1TasksNotesPost: $e\n');
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

