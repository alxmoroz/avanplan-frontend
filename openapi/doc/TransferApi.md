# openapi.api.TransferApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**projectTemplatesV1TransferProjectTemplatesGet**](TransferApi.md#projecttemplatesv1transferprojecttemplatesget) | **GET** /v1/transfer/project_templates | Project Templates


# **projectTemplatesV1TransferProjectTemplatesGet**
> BuiltList<TaskBaseGet> projectTemplatesV1TransferProjectTemplatesGet(wsId)

Project Templates

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTransferApi();
final int wsId = 56; // int | 

try {
    final response = api.projectTemplatesV1TransferProjectTemplatesGet(wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TransferApi->projectTemplatesV1TransferProjectTemplatesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 

### Return type

[**BuiltList&lt;TaskBaseGet&gt;**](TaskBaseGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

