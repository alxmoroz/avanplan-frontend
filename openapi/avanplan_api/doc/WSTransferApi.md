# avanplan_api.api.WSTransferApi

## Load the API package
```dart
import 'package:avanplan_api/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createFromTemplate**](WSTransferApi.md#createfromtemplate) | **POST** /v1/workspaces/{ws_id}/transfer/create_from_template | Create From Template
[**destinationsForMove**](WSTransferApi.md#destinationsformove) | **GET** /v1/workspaces/{ws_id}/transfer/destinations_for_move | Destinations For Move
[**projectTemplates**](WSTransferApi.md#projecttemplates) | **GET** /v1/workspaces/{ws_id}/transfer/project_templates | Project Templates
[**sourcesForMoveTasks**](WSTransferApi.md#sourcesformovetasks) | **GET** /v1/workspaces/{ws_id}/transfer/sources_for_move | Sources For Move


# **createFromTemplate**
> TasksChanges createFromTemplate(wsId, srcProjectId, srcWsId, srcTaskId, taskId)

Create From Template

### Example
```dart
import 'package:avanplan_api/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = AvanplanApi().getWSTransferApi();
final int wsId = 56; // int | 
final int srcProjectId = 56; // int | 
final int srcWsId = 56; // int | 
final int srcTaskId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.createFromTemplate(wsId, srcProjectId, srcWsId, srcTaskId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTransferApi->createFromTemplate: $e\n');
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

# **destinationsForMove**
> BuiltList<TaskGet> destinationsForMove(wsId, taskType, taskId)

Destinations For Move

### Example
```dart
import 'package:avanplan_api/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = AvanplanApi().getWSTransferApi();
final int wsId = 56; // int | 
final String taskType = taskType_example; // String | 
final int taskId = 56; // int | 

try {
    final response = api.destinationsForMove(wsId, taskType, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTransferApi->destinationsForMove: $e\n');
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

# **projectTemplates**
> BuiltList<ProjectGet> projectTemplates(wsId)

Project Templates

### Example
```dart
import 'package:avanplan_api/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = AvanplanApi().getWSTransferApi();
final int wsId = 56; // int | 

try {
    final response = api.projectTemplates(wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTransferApi->projectTemplates: $e\n');
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

# **sourcesForMoveTasks**
> BuiltList<TaskGet> sourcesForMoveTasks(wsId, taskId)

Sources For Move

### Example
```dart
import 'package:avanplan_api/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = AvanplanApi().getWSTransferApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.sourcesForMoveTasks(wsId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTransferApi->sourcesForMoveTasks: $e\n');
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

