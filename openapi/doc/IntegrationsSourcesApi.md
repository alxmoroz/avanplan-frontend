# openapi.api.IntegrationsSourcesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkConnectionV1IntegrationsSourcesCheckConnectionGet**](IntegrationsSourcesApi.md#checkconnectionv1integrationssourcescheckconnectionget) | **GET** /v1/integrations/sources/check_connection | Check Connection
[**deleteSourceV1IntegrationsSourcesSourceIdDelete**](IntegrationsSourcesApi.md#deletesourcev1integrationssourcessourceiddelete) | **DELETE** /v1/integrations/sources/{source_id} | Delete Source
[**getSourcesV1IntegrationsSourcesGet**](IntegrationsSourcesApi.md#getsourcesv1integrationssourcesget) | **GET** /v1/integrations/sources/ | Get Sources
[**upsertSourceV1IntegrationsSourcesPost**](IntegrationsSourcesApi.md#upsertsourcev1integrationssourcespost) | **POST** /v1/integrations/sources/ | Upsert Source


# **checkConnectionV1IntegrationsSourcesCheckConnectionGet**
> bool checkConnectionV1IntegrationsSourcesCheckConnectionGet(wsId, sourceId)

Check Connection

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsSourcesApi();
final int wsId = 56; // int | 
final int sourceId = 56; // int | 

try {
    final response = api.checkConnectionV1IntegrationsSourcesCheckConnectionGet(wsId, sourceId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsSourcesApi->checkConnectionV1IntegrationsSourcesCheckConnectionGet: $e\n');
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

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSourceV1IntegrationsSourcesSourceIdDelete**
> JsonObject deleteSourceV1IntegrationsSourcesSourceIdDelete(sourceId, wsId)

Delete Source

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsSourcesApi();
final int sourceId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.deleteSourceV1IntegrationsSourcesSourceIdDelete(sourceId, wsId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsSourcesApi->deleteSourceV1IntegrationsSourcesSourceIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sourceId** | **int**|  | 
 **wsId** | **int**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSourcesV1IntegrationsSourcesGet**
> BuiltList<SourceGet> getSourcesV1IntegrationsSourcesGet(wsId)

Get Sources

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsSourcesApi();
final int wsId = 56; // int | 

try {
    final response = api.getSourcesV1IntegrationsSourcesGet(wsId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsSourcesApi->getSourcesV1IntegrationsSourcesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 

### Return type

[**BuiltList&lt;SourceGet&gt;**](SourceGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertSourceV1IntegrationsSourcesPost**
> SourceGet upsertSourceV1IntegrationsSourcesPost(wsId, sourceUpsert)

Upsert Source

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsSourcesApi();
final int wsId = 56; // int | 
final SourceUpsert sourceUpsert = ; // SourceUpsert | 

try {
    final response = api.upsertSourceV1IntegrationsSourcesPost(wsId, sourceUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsSourcesApi->upsertSourceV1IntegrationsSourcesPost: $e\n');
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

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

