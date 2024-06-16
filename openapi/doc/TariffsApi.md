# openapi.api.TariffsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**availableTariffs**](TariffsApi.md#availabletariffs) | **GET** /v1/workspaces/{ws_id}/tariffs | Available Tariffs
[**sign**](TariffsApi.md#sign) | **POST** /v1/workspaces/{ws_id}/tariffs/{tariff_id}/sign | Sign
[**upsertOption**](TariffsApi.md#upsertoption) | **POST** /v1/workspaces/{ws_id}/tariffs/{tariff_id}/options/{option_id} | Upsert


# **availableTariffs**
> BuiltList<TariffGet> availableTariffs(wsId)

Available Tariffs

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
    final response = api.availableTariffs(wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TariffsApi->availableTariffs: $e\n');
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

# **sign**
> InvoiceGet sign(tariffId, wsId)

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

final api = Openapi().getTariffsApi();
final int tariffId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.sign(tariffId, wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TariffsApi->sign: $e\n');
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

# **upsertOption**
> InvoiceGet upsertOption(wsId, tariffId, optionId, enabled)

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

final api = Openapi().getTariffsApi();
final int wsId = 56; // int | 
final int tariffId = 56; // int | 
final int optionId = 56; // int | 
final bool enabled = true; // bool | 

try {
    final response = api.upsertOption(wsId, tariffId, optionId, enabled);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TariffsApi->upsertOption: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **tariffId** | **int**|  | 
 **optionId** | **int**|  | 
 **enabled** | **bool**|  | 

### Return type

[**InvoiceGet**](InvoiceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

