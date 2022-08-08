# openapi.api.TasksApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteTaskV1TasksTaskIdDelete**](TasksApi.md#deletetaskv1taskstaskiddelete) | **DELETE** /v1/tasks/{task_id} | Delete Task
[**getRootTasksV1TasksGet**](TasksApi.md#getroottasksv1tasksget) | **GET** /v1/tasks/ | Get Root Tasks
[**unlinkTasksV1TasksUnlinkPost**](TasksApi.md#unlinktasksv1tasksunlinkpost) | **POST** /v1/tasks/unlink | Unlink Tasks
[**upsertTaskV1TasksPost**](TasksApi.md#upserttaskv1taskspost) | **POST** /v1/tasks/ | Upsert Task


# **deleteTaskV1TasksTaskIdDelete**
> JsonObject deleteTaskV1TasksTaskIdDelete(taskId)

Delete Task

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int taskId = 56; // int | 

try {
    final response = api.deleteTaskV1TasksTaskIdDelete(taskId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TasksApi->deleteTaskV1TasksTaskIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRootTasksV1TasksGet**
> BuiltList<TaskGet> getRootTasksV1TasksGet(wsId)

Get Root Tasks

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final int wsId = 56; // int | 

try {
    final response = api.getRootTasksV1TasksGet(wsId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TasksApi->getRootTasksV1TasksGet: $e\n');
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

# **unlinkTasksV1TasksUnlinkPost**
> TaskGet unlinkTasksV1TasksUnlinkPost(taskUpsert)

Unlink Tasks

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final TaskUpsert taskUpsert = ; // TaskUpsert | 

try {
    final response = api.unlinkTasksV1TasksUnlinkPost(taskUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TasksApi->unlinkTasksV1TasksUnlinkPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskUpsert** | [**TaskUpsert**](TaskUpsert.md)|  | 

### Return type

[**TaskGet**](TaskGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertTaskV1TasksPost**
> TaskGet upsertTaskV1TasksPost(taskUpsert)

Upsert Task

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTasksApi();
final TaskUpsert taskUpsert = ; // TaskUpsert | 

try {
    final response = api.upsertTaskV1TasksPost(taskUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TasksApi->upsertTaskV1TasksPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskUpsert** | [**TaskUpsert**](TaskUpsert.md)|  | 

### Return type

[**TaskGet**](TaskGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

