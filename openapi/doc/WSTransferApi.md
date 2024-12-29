# openapi.api.WSTransferApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createFromTemplate_0**](WSTransferApi.md#createfromtemplate_0) | **POST** /v1/workspaces/{ws_id}/transfer/create_from_template | Create From Template
[**destinationsForMove_0**](WSTransferApi.md#destinationsformove_0) | **GET** /v1/workspaces/{ws_id}/transfer/destinations_for_move | Destinations For Move
[**projectTemplates_0**](WSTransferApi.md#projecttemplates_0) | **GET** /v1/workspaces/{ws_id}/transfer/project_templates | Project Templates
[**sourcesForMoveTasks_0**](WSTransferApi.md#sourcesformovetasks_0) | **GET** /v1/workspaces/{ws_id}/transfer/sources_for_move | Sources For Move


# **createFromTemplate_0**
> TasksChanges createFromTemplate_0(wsId, srcProjectId, srcWsId, srcTaskId, taskId)

Create From Template

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTransferApi();
final int wsId = 56; // int | 
final int srcProjectId = 56; // int | 
final int srcWsId = 56; // int | 
final int srcTaskId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.createFromTemplate_0(wsId, srcProjectId, srcWsId, srcTaskId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTransferApi->createFromTemplate_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **srcProjectId** | **int**|  | 
 **srcWsId** | **int**|  | 
 **srcTaskId** | **int**|  | [optional] 
 **taskId** | **int**|  | [optional] 

### Return type

[**TasksChanges**](TasksChanges.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **destinationsForMove_0**
> BuiltList<TaskGet> destinationsForMove_0(wsId, taskType, taskId)

Destinations For Move

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTransferApi();
final int wsId = 56; // int | 
final String taskType = taskType_example; // String | 
final int taskId = 56; // int | 

try {
    final response = api.destinationsForMove_0(wsId, taskType, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTransferApi->destinationsForMove_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskType** | **String**|  | 
 **taskId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;TaskGet&gt;**](TaskGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **projectTemplates_0**
> BuiltList<ProjectGet> projectTemplates_0(wsId)

Project Templates

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTransferApi();
final int wsId = 56; // int | 

try {
    final response = api.projectTemplates_0(wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTransferApi->projectTemplates_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 

### Return type

[**BuiltList&lt;ProjectGet&gt;**](ProjectGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sourcesForMoveTasks_0**
> BuiltList<TaskGet> sourcesForMoveTasks_0(wsId, taskId)

Sources For Move

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTransferApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.sourcesForMoveTasks_0(wsId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTransferApi->sourcesForMoveTasks_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;TaskGet&gt;**](TaskGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

