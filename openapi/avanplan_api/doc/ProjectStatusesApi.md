# avanplan_api.api.ProjectStatusesApi

## Load the API package
```dart
import 'package:avanplan_api/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteStatus_1**](ProjectStatusesApi.md#deletestatus_1) | **DELETE** /v1/workspaces/{ws_id}/tasks/{task_id}/statuses/{status_id} | Delete
[**statusTasksCount_1**](ProjectStatusesApi.md#statustaskscount_1) | **GET** /v1/workspaces/{ws_id}/tasks/{task_id}/statuses | Status Tasks Count
[**upsertStatus_1**](ProjectStatusesApi.md#upsertstatus_1) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/statuses | Upsert


# **deleteStatus_1**
> bool deleteStatus_1(statusId, wsId, taskId)

Delete

### Example
```dart
import 'package:avanplan_api/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = AvanplanApi().getProjectStatusesApi();
final int statusId = 56; // int | 
final int wsId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.deleteStatus_1(statusId, wsId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProjectStatusesApi->deleteStatus_1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **statusId** | **int**|  | 
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **statusTasksCount_1**
> int statusTasksCount_1(wsId, taskId, projectStatusId)

Status Tasks Count

### Example
```dart
import 'package:avanplan_api/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = AvanplanApi().getProjectStatusesApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int projectStatusId = 56; // int | 

try {
    final response = api.statusTasksCount_1(wsId, taskId, projectStatusId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProjectStatusesApi->statusTasksCount_1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **projectStatusId** | **int**|  | 

### Return type

**int**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertStatus_1**
> ProjectStatusGet upsertStatus_1(wsId, taskId, projectStatusUpsert)

Upsert

### Example
```dart
import 'package:avanplan_api/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = AvanplanApi().getProjectStatusesApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final ProjectStatusUpsert projectStatusUpsert = ; // ProjectStatusUpsert | 

try {
    final response = api.upsertStatus_1(wsId, taskId, projectStatusUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProjectStatusesApi->upsertStatus_1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **projectStatusUpsert** | [**ProjectStatusUpsert**](ProjectStatusUpsert.md)|  | 

### Return type

[**ProjectStatusGet**](ProjectStatusGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

