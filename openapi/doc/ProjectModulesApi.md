# openapi.api.ProjectModulesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**setupProjectModules**](ProjectModulesApi.md#setupprojectmodules) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/project_modules | Setup Project Modules


# **setupProjectModules**
> BuiltList<ProjectModuleGet> setupProjectModules(taskId, wsId, requestBody)

Setup Project Modules

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getProjectModulesApi();
final int taskId = 56; // int | 
final int wsId = 56; // int | 
final BuiltList<String> requestBody = ; // BuiltList<String> | 

try {
    final response = api.setupProjectModules(taskId, wsId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProjectModulesApi->setupProjectModules: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **wsId** | **int**|  | 
 **requestBody** | [**BuiltList&lt;String&gt;**](String.md)|  | 

### Return type

[**BuiltList&lt;ProjectModuleGet&gt;**](ProjectModuleGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

