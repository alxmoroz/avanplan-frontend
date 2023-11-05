# openapi.api.StatusesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**statusesDelete**](StatusesApi.md#statusesdelete) | **DELETE** /v1/workspaces/{ws_id}/statuses/{status_id} | Delete
[**statusesUpsert**](StatusesApi.md#statusesupsert) | **POST** /v1/workspaces/{ws_id}/statuses | Upsert
[**statusesV1WorkspacesWsIdStatusesGet**](StatusesApi.md#statusesv1workspaceswsidstatusesget) | **GET** /v1/workspaces/{ws_id}/statuses | Statuses


# **statusesDelete**
> bool statusesDelete(statusId, wsId)

Delete

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getStatusesApi();
final int statusId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.statusesDelete(statusId, wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling StatusesApi->statusesDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **statusId** | **int**|  | 
 **wsId** | **int**|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **statusesUpsert**
> StatusGet statusesUpsert(wsId, statusUpsert)

Upsert

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getStatusesApi();
final int wsId = 56; // int | 
final StatusUpsert statusUpsert = ; // StatusUpsert | 

try {
    final response = api.statusesUpsert(wsId, statusUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling StatusesApi->statusesUpsert: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **statusUpsert** | [**StatusUpsert**](StatusUpsert.md)|  | 

### Return type

[**StatusGet**](StatusGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **statusesV1WorkspacesWsIdStatusesGet**
> BuiltList<StatusGet> statusesV1WorkspacesWsIdStatusesGet(wsId)

Statuses

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getStatusesApi();
final int wsId = 56; // int | 

try {
    final response = api.statusesV1WorkspacesWsIdStatusesGet(wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling StatusesApi->statusesV1WorkspacesWsIdStatusesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 

### Return type

[**BuiltList&lt;StatusGet&gt;**](StatusGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

