# openapi.api.ContractsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**signV1ContractsSignPost**](ContractsApi.md#signv1contractssignpost) | **POST** /v1/contracts/sign | Sign


# **signV1ContractsSignPost**
> InvoiceGet signV1ContractsSignPost(tariffId, wsId)

Sign

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getContractsApi();
final int tariffId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.signV1ContractsSignPost(tariffId, wsId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ContractsApi->signV1ContractsSignPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tariffId** | **int**|  | 
 **wsId** | **int**|  | 

### Return type

[**InvoiceGet**](InvoiceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

