# openapi.api.MyProjectsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**myProjectsV1MyProjectsGet**](MyProjectsApi.md#myprojectsv1myprojectsget) | **GET** /v1/my/projects | My Projects


# **myProjectsV1MyProjectsGet**
> BuiltList<TaskGet> myProjectsV1MyProjectsGet(wsId, closed, imported)

My Projects

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyProjectsApi();
final int wsId = 56; // int | 
final bool closed = true; // bool | 
final bool imported = true; // bool | 

try {
    final response = api.myProjectsV1MyProjectsGet(wsId, closed, imported);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MyProjectsApi->myProjectsV1MyProjectsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **closed** | **bool**|  | [optional] 
 **imported** | **bool**|  | [optional] 

### Return type

[**BuiltList&lt;TaskGet&gt;**](TaskGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

