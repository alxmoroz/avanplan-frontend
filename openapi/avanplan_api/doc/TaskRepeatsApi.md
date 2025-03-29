# avanplan_api.api.TaskRepeatsApi

## Load the API package
```dart
import 'package:avanplan_api/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteRepeat**](TaskRepeatsApi.md#deleterepeat) | **DELETE** /v1/workspaces/{ws_id}/tasks/{task_id}/repeats/{repeat_id} | Delete
[**upsertRepeat**](TaskRepeatsApi.md#upsertrepeat) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/repeats | Upsert


# **deleteRepeat**
> bool deleteRepeat(wsId, taskId, repeatId)

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

final api = AvanplanApi().getTaskRepeatsApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int repeatId = 56; // int | 

try {
    final response = api.deleteRepeat(wsId, taskId, repeatId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TaskRepeatsApi->deleteRepeat: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **repeatId** | **int**|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertRepeat**
> TaskRepeatGet upsertRepeat(wsId, taskId, taskRepeatUpsert)

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

final api = AvanplanApi().getTaskRepeatsApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final TaskRepeatUpsert taskRepeatUpsert = ; // TaskRepeatUpsert | 

try {
    final response = api.upsertRepeat(wsId, taskId, taskRepeatUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TaskRepeatsApi->upsertRepeat: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **taskRepeatUpsert** | [**TaskRepeatUpsert**](TaskRepeatUpsert.md)|  | 

### Return type

[**TaskRepeatGet**](TaskRepeatGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

