# openapi.api.WSSourcesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkConnection_0**](WSSourcesApi.md#checkconnection_0) | **GET** /v1/workspaces/{ws_id}/sources/{source_id}/check_connection | Check Connection
[**deleteSource_0**](WSSourcesApi.md#deletesource_0) | **DELETE** /v1/workspaces/{ws_id}/sources/{source_id} | Delete
[**getProjects_0**](WSSourcesApi.md#getprojects_0) | **GET** /v1/workspaces/{ws_id}/sources/{source_id}/projects | Get Projects
[**requestType_0**](WSSourcesApi.md#requesttype_0) | **POST** /v1/workspaces/{ws_id}/sources/request_type | Request Type
[**startImport_0**](WSSourcesApi.md#startimport_0) | **POST** /v1/workspaces/{ws_id}/sources/{source_id}/start_import | Start Import
[**upsertSource_0**](WSSourcesApi.md#upsertsource_0) | **POST** /v1/workspaces/{ws_id}/sources | Upsert


# **checkConnection_0**
> bool checkConnection_0(wsId, sourceId)

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

final api = Openapi().getWSSourcesApi();
final int wsId = 56; // int | 
final int sourceId = 56; // int | 

try {
    final response = api.checkConnection_0(wsId, sourceId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSSourcesApi->checkConnection_0: $e\n');
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

# **deleteSource_0**
> bool deleteSource_0(sourceId, wsId)

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

final api = Openapi().getWSSourcesApi();
final int sourceId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.deleteSource_0(sourceId, wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSSourcesApi->deleteSource_0: $e\n');
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

# **getProjects_0**
> BuiltList<TaskRemote> getProjects_0(wsId, sourceId)

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

final api = Openapi().getWSSourcesApi();
final int wsId = 56; // int | 
final int sourceId = 56; // int | 

try {
    final response = api.getProjects_0(wsId, sourceId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSSourcesApi->getProjects_0: $e\n');
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

# **requestType_0**
> bool requestType_0(wsId, bodyRequestType)

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

final api = Openapi().getWSSourcesApi();
final int wsId = 56; // int | 
final BodyRequestType bodyRequestType = ; // BodyRequestType | 

try {
    final response = api.requestType_0(wsId, bodyRequestType);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSSourcesApi->requestType_0: $e\n');
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

# **startImport_0**
> bool startImport_0(wsId, sourceId, bodyStartImport)

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

final api = Openapi().getWSSourcesApi();
final int wsId = 56; // int | 
final int sourceId = 56; // int | 
final BodyStartImport bodyStartImport = ; // BodyStartImport | 

try {
    final response = api.startImport_0(wsId, sourceId, bodyStartImport);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSSourcesApi->startImport_0: $e\n');
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

# **upsertSource_0**
> SourceGet upsertSource_0(wsId, sourceUpsert)

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

final api = Openapi().getWSSourcesApi();
final int wsId = 56; // int | 
final SourceUpsert sourceUpsert = ; // SourceUpsert | 

try {
    final response = api.upsertSource_0(wsId, sourceUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSSourcesApi->upsertSource_0: $e\n');
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

