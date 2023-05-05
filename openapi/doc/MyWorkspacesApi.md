# openapi.api.MyWorkspacesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createWorkspaceV1MyWorkspacesCreatePost**](MyWorkspacesApi.md#createworkspacev1myworkspacescreatepost) | **POST** /v1/my/workspaces/create | Create Workspace
[**updateWorkspaceV1MyWorkspacesUpdatePost**](MyWorkspacesApi.md#updateworkspacev1myworkspacesupdatepost) | **POST** /v1/my/workspaces/update | Update Workspace
[**workspacesV1MyWorkspacesGet**](MyWorkspacesApi.md#workspacesv1myworkspacesget) | **GET** /v1/my/workspaces | Workspaces


# **createWorkspaceV1MyWorkspacesCreatePost**
> WorkspaceGet createWorkspaceV1MyWorkspacesCreatePost(workspaceUpsert)

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

final api = Openapi().getMyWorkspacesApi();
final WorkspaceUpsert workspaceUpsert = ; // WorkspaceUpsert | 

try {
    final response = api.createWorkspaceV1MyWorkspacesCreatePost(workspaceUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyWorkspacesApi->createWorkspaceV1MyWorkspacesCreatePost: $e\n');
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

# **updateWorkspaceV1MyWorkspacesUpdatePost**
> WorkspaceGet updateWorkspaceV1MyWorkspacesUpdatePost(wsId, workspaceUpsert)

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

final api = Openapi().getMyWorkspacesApi();
final int wsId = 56; // int | 
final WorkspaceUpsert workspaceUpsert = ; // WorkspaceUpsert | 

try {
    final response = api.updateWorkspaceV1MyWorkspacesUpdatePost(wsId, workspaceUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyWorkspacesApi->updateWorkspaceV1MyWorkspacesUpdatePost: $e\n');
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

# **workspacesV1MyWorkspacesGet**
> BuiltList<WorkspaceGet> workspacesV1MyWorkspacesGet()

Workspaces

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyWorkspacesApi();

try {
    final response = api.workspacesV1MyWorkspacesGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyWorkspacesApi->workspacesV1MyWorkspacesGet: $e\n');
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

