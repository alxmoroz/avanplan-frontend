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
[**getSourceTypesV1IntegrationsSourcesTypesGet**](IntegrationsSourcesApi.md#getsourcetypesv1integrationssourcestypesget) | **GET** /v1/integrations/sources/types/ | Get Source Types
[**upsertSourceV1IntegrationsSourcesPost**](IntegrationsSourcesApi.md#upsertsourcev1integrationssourcespost) | **POST** /v1/integrations/sources/ | Upsert Source


# **checkConnectionV1IntegrationsSourcesCheckConnectionGet**
> bool checkConnectionV1IntegrationsSourcesCheckConnectionGet(sourceId)

Check Connection

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsSourcesApi();
final int sourceId = 56; // int | 

try {
    final response = api.checkConnectionV1IntegrationsSourcesCheckConnectionGet(sourceId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsSourcesApi->checkConnectionV1IntegrationsSourcesCheckConnectionGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
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
> JsonObject deleteSourceV1IntegrationsSourcesSourceIdDelete(sourceId)

Delete Source

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsSourcesApi();
final int sourceId = 56; // int | 

try {
    final response = api.deleteSourceV1IntegrationsSourcesSourceIdDelete(sourceId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsSourcesApi->deleteSourceV1IntegrationsSourcesSourceIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sourceId** | **int**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSourceTypesV1IntegrationsSourcesTypesGet**
> BuiltList<SourceTypeGet> getSourceTypesV1IntegrationsSourcesTypesGet()

Get Source Types

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsSourcesApi();

try {
    final response = api.getSourceTypesV1IntegrationsSourcesTypesGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsSourcesApi->getSourceTypesV1IntegrationsSourcesTypesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;SourceTypeGet&gt;**](SourceTypeGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertSourceV1IntegrationsSourcesPost**
> SourceGet upsertSourceV1IntegrationsSourcesPost(sourceUpsert)

Upsert Source

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getIntegrationsSourcesApi();
final SourceUpsert sourceUpsert = ; // SourceUpsert | 

try {
    final response = api.upsertSourceV1IntegrationsSourcesPost(sourceUpsert);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntegrationsSourcesApi->upsertSourceV1IntegrationsSourcesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sourceUpsert** | [**SourceUpsert**](SourceUpsert.md)|  | 

### Return type

[**SourceGet**](SourceGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

