# openapi.api.TariffOptionsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**upsertOption**](TariffOptionsApi.md#upsertoption) | **POST** /v1/workspaces/{ws_id}/tariffs/{tariff_id}/options/{option_id} | Upsert


# **upsertOption**
> InvoiceGet upsertOption(wsId, tariffId, optionId, subscribe)

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

final api = Openapi().getTariffOptionsApi();
final int wsId = 56; // int | 
final int tariffId = 56; // int | 
final int optionId = 56; // int | 
final bool subscribe = true; // bool | 

try {
    final response = api.upsertOption(wsId, tariffId, optionId, subscribe);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TariffOptionsApi->upsertOption: $e\n');
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

