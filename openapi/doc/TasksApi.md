# openapi.api.TasksApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteV1TasksTaskIdDelete**](TasksApi.md#deletev1taskstaskiddelete) | **DELETE** /v1/tasks/{task_id} | Delete
[**projectsV1TasksGet**](TasksApi.md#projectsv1tasksget) | **GET** /v1/tasks/ | Projects
[**upsertV1TasksPost**](TasksApi.md#upsertv1taskspost) | **POST** /v1/tasks/ | Upsert


# **deleteV1TasksTaskIdDelete**
> JsonObject deleteV1TasksTaskIdDelete(taskId, wsId)

Delete

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int taskId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.deleteV1TasksTaskIdDelete(taskId, wsId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TasksApi->deleteV1TasksTaskIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **wsId** | **int**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **projectsV1TasksGet**
> BuiltList<TaskGet> projectsV1TasksGet(wsId)

Projects

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int wsId = 56; // int | 

try {
    final response = api.projectsV1TasksGet(wsId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TasksApi->projectsV1TasksGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 

### Return type

[**BuiltList&lt;TaskGet&gt;**](TaskGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertV1TasksPost**
> TaskGet upsertV1TasksPost(wsId, taskUpsert)

Upsert

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int wsId = 56; // int | 
final TaskUpsert taskUpsert = ; // TaskUpsert | 

try {
    final response = api.upsertV1TasksPost(wsId, taskUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TasksApi->upsertV1TasksPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskUpsert** | [**TaskUpsert**](TaskUpsert.md)|  | 

### Return type

[**TaskGet**](TaskGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

