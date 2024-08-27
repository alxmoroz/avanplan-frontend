# openapi.api.MembersApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**memberAssignedTasks**](MembersApi.md#memberassignedtasks) | **GET** /v1/workspaces/{ws_id}/members/{member_id}/assigned_tasks | Member Assigned Tasks


# **memberAssignedTasks**
> BuiltList<TaskGet> memberAssignedTasks(memberId, wsId)

Member Assigned Tasks

Задачи участника РП

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMembersApi();
final int memberId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.memberAssignedTasks(memberId, wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MembersApi->memberAssignedTasks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **memberId** | **int**|  | 
 **wsId** | **int**|  | 

### Return type

[**BuiltList&lt;TaskGet&gt;**](TaskGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

