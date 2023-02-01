# openapi.api.SettingsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getEstimateValuesV1SettingsEstimateValuesGet**](SettingsApi.md#getestimatevaluesv1settingsestimatevaluesget) | **GET** /v1/settings/estimate_values | Get Estimate Values
[**getSettingsV1SettingsGet**](SettingsApi.md#getsettingsv1settingsget) | **GET** /v1/settings/ | Get Settings


# **getEstimateValuesV1SettingsEstimateValuesGet**
> BuiltList<EstimateValueGet> getEstimateValuesV1SettingsEstimateValuesGet(wsId)

Get Estimate Values

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getSettingsApi();
final int wsId = 56; // int | 

try {
    final response = api.getEstimateValuesV1SettingsEstimateValuesGet(wsId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling SettingsApi->getEstimateValuesV1SettingsEstimateValuesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 

### Return type

[**BuiltList&lt;EstimateValueGet&gt;**](EstimateValueGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSettingsV1SettingsGet**
> SettingsGet getSettingsV1SettingsGet(wsId)

Get Settings

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getSettingsApi();
final int wsId = 56; // int | 

try {
    final response = api.getSettingsV1SettingsGet(wsId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling SettingsApi->getSettingsV1SettingsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 

### Return type

[**SettingsGet**](SettingsGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

