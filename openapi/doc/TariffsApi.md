# openapi.api.TariffsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**tariffsV1RefsTariffsGet**](TariffsApi.md#tariffsv1refstariffsget) | **GET** /v1/refs/tariffs | Tariffs


# **tariffsV1RefsTariffsGet**
> BuiltList<TariffGet> tariffsV1RefsTariffsGet(wsId)

Tariffs

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getTariffsApi();
final int wsId = 56; // int | 

try {
    final response = api.tariffsV1RefsTariffsGet(wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TariffsApi->tariffsV1RefsTariffsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 

### Return type

[**BuiltList&lt;TariffGet&gt;**](TariffGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

