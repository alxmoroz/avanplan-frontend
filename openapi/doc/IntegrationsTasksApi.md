# openapi.api.IntegrationsTasksApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**importTaskSourcesV1IntegrationsTasksImportPost**](IntegrationsTasksApi.md#importtasksourcesv1integrationstasksimportpost) | **POST** /v1/integrations/tasks/import | Import Task Sources
[**rootTasksV1IntegrationsTasksGet**](IntegrationsTasksApi.md#roottasksv1integrationstasksget) | **GET** /v1/integrations/tasks | Root Tasks
[**unlinkV1IntegrationsTasksUnlinkPost**](IntegrationsTasksApi.md#unlinkv1integrationstasksunlinkpost) | **POST** /v1/integrations/tasks/unlink | Unlink


# **importTaskSourcesV1IntegrationsTasksImportPost**
> bool importTaskSourcesV1IntegrationsTasksImportPost(wsId, sourceId, taskSource)

Import Task Sources

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
final BuiltList<TaskSource> taskSource = ; // BuiltList<TaskSource> | 

try {
    final response = api.importTaskSourcesV1IntegrationsTasksImportPost(wsId, sourceId, taskSource);
    print(response);
} catch on DioException (e) {
    print('Exception when calling IntegrationsTasksApi->importTaskSourcesV1IntegrationsTasksImportPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **sourceId** | **int**|  | 
 **taskSource** | [**BuiltList&lt;TaskSource&gt;**](TaskSource.md)|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rootTasksV1IntegrationsTasksGet**
> BuiltList<TaskRemote> rootTasksV1IntegrationsTasksGet(wsId, sourceId)

Root Tasks

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
    final response = api.rootTasksV1IntegrationsTasksGet(wsId, sourceId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling IntegrationsTasksApi->rootTasksV1IntegrationsTasksGet: $e\n');
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

