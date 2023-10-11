# openapi.api.WorkspacesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createWorkspaceV1WorkspacesPost**](WorkspacesApi.md#createworkspacev1workspacespost) | **POST** /v1/workspaces | Create Workspace
[**getMyWorkspacesV1WorkspacesGet**](WorkspacesApi.md#getmyworkspacesv1workspacesget) | **GET** /v1/workspaces | Get My Workspaces
[**getWorkspaceV1WorkspacesWsIdGet**](WorkspacesApi.md#getworkspacev1workspaceswsidget) | **GET** /v1/workspaces/{ws_id} | Get Workspace
[**updateWorkspaceV1WorkspacesWsIdPost**](WorkspacesApi.md#updateworkspacev1workspaceswsidpost) | **POST** /v1/workspaces/{ws_id} | Update Workspace


# **createWorkspaceV1WorkspacesPost**
> WorkspaceGet createWorkspaceV1WorkspacesPost(workspaceUpsert)

Create Workspace

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWorkspacesApi();
final WorkspaceUpsert workspaceUpsert = ; // WorkspaceUpsert | 

try {
    final response = api.createWorkspaceV1WorkspacesPost(workspaceUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WorkspacesApi->createWorkspaceV1WorkspacesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **workspaceUpsert** | [**WorkspaceUpsert**](WorkspaceUpsert.md)|  | [optional] 

### Return type

[**WorkspaceGet**](WorkspaceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyWorkspacesV1WorkspacesGet**
> BuiltList<WorkspaceGet> getMyWorkspacesV1WorkspacesGet()

Get My Workspaces

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWorkspacesApi();

try {
    final response = api.getMyWorkspacesV1WorkspacesGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling WorkspacesApi->getMyWorkspacesV1WorkspacesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;WorkspaceGet&gt;**](WorkspaceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWorkspaceV1WorkspacesWsIdGet**
> WorkspaceGet getWorkspaceV1WorkspacesWsIdGet(wsId)

Get Workspace

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWorkspacesApi();
final int wsId = 56; // int | 

try {
    final response = api.getWorkspaceV1WorkspacesWsIdGet(wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WorkspacesApi->getWorkspaceV1WorkspacesWsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 

### Return type

[**WorkspaceGet**](WorkspaceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateWorkspaceV1WorkspacesWsIdPost**
> WorkspaceGet updateWorkspaceV1WorkspacesWsIdPost(wsId, workspaceUpsert)

Update Workspace

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWorkspacesApi();
final int wsId = 56; // int | 
final WorkspaceUpsert workspaceUpsert = ; // WorkspaceUpsert | 

try {
    final response = api.updateWorkspaceV1WorkspacesWsIdPost(wsId, workspaceUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WorkspacesApi->updateWorkspaceV1WorkspacesWsIdPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **workspaceUpsert** | [**WorkspaceUpsert**](WorkspaceUpsert.md)|  | 

### Return type

[**WorkspaceGet**](WorkspaceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

