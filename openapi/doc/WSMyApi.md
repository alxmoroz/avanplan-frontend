# openapi.api.WSMyApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**myProjects**](WSMyApi.md#myprojects) | **GET** /v1/workspaces/{ws_id}/my/projects | Projects
[**myTasks**](WSMyApi.md#mytasks) | **GET** /v1/workspaces/{ws_id}/my/tasks | Tasks


# **myProjects**
> BuiltList<TaskGet> myProjects(wsId, closed, imported, taskId)

Projects

Мои проекты, куда у меня есть доступ, в том числе Входящие

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSMyApi();
final int wsId = 56; // int | 
final bool closed = true; // bool | 
final bool imported = true; // bool | 
final int taskId = 56; // int | 

try {
    final response = api.myProjects(wsId, closed, imported, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSMyApi->myProjects: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **closed** | **bool**|  | [optional] 
 **imported** | **bool**|  | [optional] 
 **taskId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;TaskGet&gt;**](TaskGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **myTasks**
> BuiltList<TaskGet> myTasks(wsId, projectId, taskId)

Tasks

Мои задачи

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSMyApi();
final int wsId = 56; // int | 
final int projectId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.myTasks(wsId, projectId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSMyApi->myTasks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **projectId** | **int**|  | [optional] 
 **taskId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;TaskGet&gt;**](TaskGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

