# openapi.api.WSTariffsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**availableTariffs_0**](WSTariffsApi.md#availabletariffs_0) | **GET** /v1/workspaces/{ws_id}/tariffs | Available Tariffs
[**sign_0**](WSTariffsApi.md#sign_0) | **POST** /v1/workspaces/{ws_id}/tariffs/{tariff_id}/sign | Sign
[**upsertOption_0**](WSTariffsApi.md#upsertoption_0) | **POST** /v1/workspaces/{ws_id}/tariffs/{tariff_id}/options/{option_id} | Upsert


# **availableTariffs_0**
> BuiltList<TariffGet> availableTariffs_0(wsId)

Available Tariffs

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getWSTariffsApi();
final int wsId = 56; // int | 

try {
    final response = api.availableTariffs_0(wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTariffsApi->availableTariffs_0: $e\n');
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

# **sign_0**
> InvoiceGet sign_0(tariffId, wsId)

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

final api = Openapi().getWSTariffsApi();
final int tariffId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.sign_0(tariffId, wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTariffsApi->sign_0: $e\n');
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

# **upsertOption_0**
> InvoiceGet upsertOption_0(wsId, tariffId, optionId, subscribe)

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

final api = Openapi().getWSTariffsApi();
final int wsId = 56; // int | 
final int tariffId = 56; // int | 
final int optionId = 56; // int | 
final bool subscribe = true; // bool | 

try {
    final response = api.upsertOption_0(wsId, tariffId, optionId, subscribe);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTariffsApi->upsertOption_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **tariffId** | **int**|  | 
 **optionId** | **int**|  | 
 **subscribe** | **bool**|  | 

### Return type

[**InvoiceGet**](InvoiceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

