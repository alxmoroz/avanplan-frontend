# openapi.api.SourcesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkConnection**](SourcesApi.md#checkconnection) | **GET** /v1/workspaces/{ws_id}/sources/{source_id}/check_connection | Check Connection
[**deleteSource**](SourcesApi.md#deletesource) | **DELETE** /v1/workspaces/{ws_id}/sources/{source_id} | Delete
[**getProjects**](SourcesApi.md#getprojects) | **GET** /v1/workspaces/{ws_id}/sources/{source_id}/projects | Get Projects
[**requestType**](SourcesApi.md#requesttype) | **POST** /v1/workspaces/{ws_id}/sources/request_type | Request Type
[**startImport**](SourcesApi.md#startimport) | **POST** /v1/workspaces/{ws_id}/sources/{source_id}/start_import | Start Import
[**upsertSource**](SourcesApi.md#upsertsource) | **POST** /v1/workspaces/{ws_id}/sources | Upsert


# **checkConnection**
> bool checkConnection(wsId, sourceId)

Check Connection

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getSourcesApi();
final int wsId = 56; // int | 
final int sourceId = 56; // int | 

try {
    final response = api.checkConnection(wsId, sourceId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SourcesApi->checkConnection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **sourceId** | **int**|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSource**
> bool deleteSource(sourceId, wsId)

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

final api = Openapi().getSourcesApi();
final int sourceId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.deleteSource(sourceId, wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SourcesApi->deleteSource: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sourceId** | **int**|  | 
 **wsId** | **int**|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProjects**
> BuiltList<TaskRemote> getProjects(wsId, sourceId)

Get Projects

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getSourcesApi();
final int wsId = 56; // int | 
final int sourceId = 56; // int | 

try {
    final response = api.getProjects(wsId, sourceId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SourcesApi->getProjects: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **sourceId** | **int**|  | 

### Return type

[**BuiltList&lt;TaskRemote&gt;**](TaskRemote.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestType**
> bool requestType(wsId, bodyRequestType)

Request Type

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getSourcesApi();
final int wsId = 56; // int | 
final BodyRequestType bodyRequestType = ; // BodyRequestType | 

try {
    final response = api.requestType(wsId, bodyRequestType);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SourcesApi->requestType: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **bodyRequestType** | [**BodyRequestType**](BodyRequestType.md)|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **startImport**
> bool startImport(wsId, sourceId, bodyStartImport)

Start Import

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getSourcesApi();
final int wsId = 56; // int | 
final int sourceId = 56; // int | 
final BodyStartImport bodyStartImport = ; // BodyStartImport | 

try {
    final response = api.startImport(wsId, sourceId, bodyStartImport);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SourcesApi->startImport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **sourceId** | **int**|  | 
 **bodyStartImport** | [**BodyStartImport**](BodyStartImport.md)|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertSource**
> SourceGet upsertSource(wsId, sourceUpsert)

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

final api = Openapi().getSourcesApi();
final int wsId = 56; // int | 
final SourceUpsert sourceUpsert = ; // SourceUpsert | 

try {
    final response = api.upsertSource(wsId, sourceUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SourcesApi->upsertSource: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **sourceUpsert** | [**SourceUpsert**](SourceUpsert.md)|  | 

### Return type

[**SourceGet**](SourceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

