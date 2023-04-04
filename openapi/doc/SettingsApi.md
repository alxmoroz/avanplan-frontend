# openapi.api.SettingsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getSettingsV1SettingsGet**](SettingsApi.md#getsettingsv1settingsget) | **GET** /v1/settings/ | Get Settings


# **getSettingsV1SettingsGet**
> AppSettingsGet getSettingsV1SettingsGet()

Get Settings

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getSettingsApi();

try {
    final response = api.getSettingsV1SettingsGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling SettingsApi->getSettingsV1SettingsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AppSettingsGet**](AppSettingsGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

