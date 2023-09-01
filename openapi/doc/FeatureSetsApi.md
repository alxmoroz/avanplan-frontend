# openapi.api.FeatureSetsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**featureSetsV1FeatureSetsGet**](FeatureSetsApi.md#featuresetsv1featuresetsget) | **GET** /v1/feature_sets/ | Feature Sets


# **featureSetsV1FeatureSetsGet**
> BuiltList<FeatureSetGet> featureSetsV1FeatureSetsGet()

Feature Sets

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getFeatureSetsApi();

try {
    final response = api.featureSetsV1FeatureSetsGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling FeatureSetsApi->featureSetsV1FeatureSetsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;FeatureSetGet&gt;**](FeatureSetGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

