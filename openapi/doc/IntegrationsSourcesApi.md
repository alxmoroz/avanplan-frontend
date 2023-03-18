# openapi.api.IntegrationsSourcesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkConnectionV1IntegrationsSourcesCheckConnectionGet**](IntegrationsSourcesApi.md#checkconnectionv1integrationssourcescheckconnectionget) | **GET** /v1/integrations/sources/check_connection | Check Connection
[**deleteV1IntegrationsSourcesSourceIdDelete**](IntegrationsSourcesApi.md#deletev1integrationssourcessourceiddelete) | **DELETE** /v1/integrations/sources/{source_id} | Delete
[**upsertV1IntegrationsSourcesPost**](IntegrationsSourcesApi.md#upsertv1integrationssourcespost) | **POST** /v1/integrations/sources/ | Upsert


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

# **deleteV1IntegrationsSourcesSourceIdDelete**
> bool deleteV1IntegrationsSourcesSourceIdDelete(sourceId, wsId)

Delete

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsSourcesApi();
final int sourceId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.deleteV1IntegrationsSourcesSourceIdDelete(sourceId, wsId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsSourcesApi->deleteV1IntegrationsSourcesSourceIdDelete: $e\n');
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

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertV1IntegrationsSourcesPost**
> SourceGet upsertV1IntegrationsSourcesPost(wsId, sourceUpsert)

Upsert

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsSourcesApi();
final int wsId = 56; // int | 
final SourceUpsert sourceUpsert = ; // SourceUpsert | 

try {
    final response = api.upsertV1IntegrationsSourcesPost(wsId, sourceUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsSourcesApi->upsertV1IntegrationsSourcesPost: $e\n');
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

