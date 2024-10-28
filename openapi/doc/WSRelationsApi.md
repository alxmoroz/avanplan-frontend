# openapi.api.WSRelationsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteRelation**](WSRelationsApi.md#deleterelation) | **DELETE** /v1/workspaces/{ws_id}/relations/{relation_id} | Delete Relation
[**sourcesForRelations**](WSRelationsApi.md#sourcesforrelations) | **GET** /v1/workspaces/{ws_id}/relations/sources | Sources For Relations
[**upsertRelation**](WSRelationsApi.md#upsertrelation) | **POST** /v1/workspaces/{ws_id}/relations | Upsert Relation


# **deleteRelation**
> bool deleteRelation(wsId, relationId, taskId)

Delete Relation

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSRelationsApi();
final int wsId = 56; // int | 
final int relationId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.deleteRelation(wsId, relationId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSRelationsApi->deleteRelation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **relationId** | **int**|  | 
 **taskId** | **int**|  | [optional] 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sourcesForRelations**
> BuiltList<TaskGet> sourcesForRelations(wsId, taskId)

Sources For Relations

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSRelationsApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.sourcesForRelations(wsId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSRelationsApi->sourcesForRelations: $e\n');
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

# **upsertRelation**
> TaskRelationGet upsertRelation(wsId, taskRelationUpsert, taskId)

Upsert Relation

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSRelationsApi();
final int wsId = 56; // int | 
final TaskRelationUpsert taskRelationUpsert = ; // TaskRelationUpsert | 
final int taskId = 56; // int | 

try {
    final response = api.upsertRelation(wsId, taskRelationUpsert, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSRelationsApi->upsertRelation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskRelationUpsert** | [**TaskRelationUpsert**](TaskRelationUpsert.md)|  | 
 **taskId** | **int**|  | [optional] 

### Return type

[**TaskRelationGet**](TaskRelationGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

