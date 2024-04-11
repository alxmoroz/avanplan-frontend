# openapi.api.MyTasksApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**myTasks**](MyTasksApi.md#mytasks) | **GET** /v1/my/tasks | My Tasks


# **myTasks**
> BuiltList<TaskGet> myTasks(wsId)

My Tasks

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

final api = Openapi().getMyTasksApi();
final int wsId = 56; // int | 

try {
    final response = api.myTasks(wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MyTasksApi->myTasks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 

### Return type

[**BuiltList&lt;TaskGet&gt;**](TaskGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

