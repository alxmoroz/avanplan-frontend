# openapi.api.IntegrationsTasksApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getProjectsListV1IntegrationsTasksGet**](IntegrationsTasksApi.md#getprojectslistv1integrationstasksget) | **GET** /v1/integrations/tasks | Get Projects List
[**importProjectsV1IntegrationsTasksImportPost**](IntegrationsTasksApi.md#importprojectsv1integrationstasksimportpost) | **POST** /v1/integrations/tasks/import | Import Projects
[**unlinkV1IntegrationsTasksUnlinkPost**](IntegrationsTasksApi.md#unlinkv1integrationstasksunlinkpost) | **POST** /v1/integrations/tasks/unlink | Unlink


# **getProjectsListV1IntegrationsTasksGet**
> BuiltList<TaskRemote> getProjectsListV1IntegrationsTasksGet(wsId, sourceId)

Get Projects List

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsTasksApi();
final int wsId = 56; // int | 
final int sourceId = 56; // int | 

try {
    final response = api.getProjectsListV1IntegrationsTasksGet(wsId, sourceId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling IntegrationsTasksApi->getProjectsListV1IntegrationsTasksGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **sourceId** | **int**|  | 

### Return type

[**BuiltList&lt;TaskRemote&gt;**](TaskRemote.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **importProjectsV1IntegrationsTasksImportPost**
> BuiltList<TaskRemote> importProjectsV1IntegrationsTasksImportPost(wsId, sourceId, taskRemote)

Import Projects

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsTasksApi();
final int wsId = 56; // int | 
final int sourceId = 56; // int | 
final BuiltList<TaskRemote> taskRemote = ; // BuiltList<TaskRemote> | 

try {
    final response = api.importProjectsV1IntegrationsTasksImportPost(wsId, sourceId, taskRemote);
    print(response);
} catch on DioException (e) {
    print('Exception when calling IntegrationsTasksApi->importProjectsV1IntegrationsTasksImportPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **sourceId** | **int**|  | 
 **taskRemote** | [**BuiltList&lt;TaskRemote&gt;**](TaskRemote.md)|  | 

### Return type

[**BuiltList&lt;TaskRemote&gt;**](TaskRemote.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unlinkV1IntegrationsTasksUnlinkPost**
> bool unlinkV1IntegrationsTasksUnlinkPost(taskId, wsId)

Unlink

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsTasksApi();
final int taskId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.unlinkV1IntegrationsTasksUnlinkPost(taskId, wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling IntegrationsTasksApi->unlinkV1IntegrationsTasksUnlinkPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **wsId** | **int**|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

