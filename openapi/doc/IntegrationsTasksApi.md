# openapi.api.IntegrationsTasksApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getRootTasksV1IntegrationsTasksGet**](IntegrationsTasksApi.md#getroottasksv1integrationstasksget) | **GET** /v1/integrations/tasks/ | Get Root Tasks
[**importTaskSourcesV1IntegrationsTasksImportPost**](IntegrationsTasksApi.md#importtasksourcesv1integrationstasksimportpost) | **POST** /v1/integrations/tasks/import | Import Task Sources
[**updateTaskSourcesV1IntegrationsTasksUpdateTaskSourcesPost**](IntegrationsTasksApi.md#updatetasksourcesv1integrationstasksupdatetasksourcespost) | **POST** /v1/integrations/tasks/update_task_sources | Update Task Sources


# **getRootTasksV1IntegrationsTasksGet**
> BuiltList<Task> getRootTasksV1IntegrationsTasksGet(sourceId)

Get Root Tasks

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsTasksApi();
final int sourceId = 56; // int | 

try {
    final response = api.getRootTasksV1IntegrationsTasksGet(sourceId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsTasksApi->getRootTasksV1IntegrationsTasksGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sourceId** | **int**|  | 

### Return type

[**BuiltList&lt;Task&gt;**](Task.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **importTaskSourcesV1IntegrationsTasksImportPost**
> Msg importTaskSourcesV1IntegrationsTasksImportPost(sourceId, taskSource)

Import Task Sources

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsTasksApi();
final int sourceId = 56; // int | 
final BuiltList<TaskSource> taskSource = ; // BuiltList<TaskSource> | 

try {
    final response = api.importTaskSourcesV1IntegrationsTasksImportPost(sourceId, taskSource);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsTasksApi->importTaskSourcesV1IntegrationsTasksImportPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sourceId** | **int**|  | 
 **taskSource** | [**BuiltList&lt;TaskSource&gt;**](TaskSource.md)|  | 

### Return type

[**Msg**](Msg.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateTaskSourcesV1IntegrationsTasksUpdateTaskSourcesPost**
> Msg updateTaskSourcesV1IntegrationsTasksUpdateTaskSourcesPost(taskSourceUpsert)

Update Task Sources

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsTasksApi();
final BuiltList<TaskSourceUpsert> taskSourceUpsert = ; // BuiltList<TaskSourceUpsert> | 

try {
    final response = api.updateTaskSourcesV1IntegrationsTasksUpdateTaskSourcesPost(taskSourceUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsTasksApi->updateTaskSourcesV1IntegrationsTasksUpdateTaskSourcesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskSourceUpsert** | [**BuiltList&lt;TaskSourceUpsert&gt;**](TaskSourceUpsert.md)|  | 

### Return type

[**Msg**](Msg.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

