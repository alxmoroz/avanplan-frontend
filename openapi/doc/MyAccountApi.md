# openapi.api.MyAccountApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accountV1MyAccountGet**](MyAccountApi.md#accountv1myaccountget) | **GET** /v1/my/account | Account
[**deleteAccountV1MyAccountDelete**](MyAccountApi.md#deleteaccountv1myaccountdelete) | **DELETE** /v1/my/account | Delete Account
[**updateAccountV1MyAccountPost**](MyAccountApi.md#updateaccountv1myaccountpost) | **POST** /v1/my/account | Update Account


# **accountV1MyAccountGet**
> MyUser accountV1MyAccountGet()

Account

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyAccountApi();

try {
    final response = api.accountV1MyAccountGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MyAccountApi->accountV1MyAccountGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MyUser**](MyUser.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteAccountV1MyAccountDelete**
> bool deleteAccountV1MyAccountDelete()

Delete Account

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyAccountApi();

try {
    final response = api.deleteAccountV1MyAccountDelete();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MyAccountApi->deleteAccountV1MyAccountDelete: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateAccountV1MyAccountPost**
> MyUser updateAccountV1MyAccountPost(bodyUpdateAccountV1MyAccountPost)

Update Account

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyAccountApi();
final BodyUpdateAccountV1MyAccountPost bodyUpdateAccountV1MyAccountPost = ; // BodyUpdateAccountV1MyAccountPost | 

try {
    final response = api.updateAccountV1MyAccountPost(bodyUpdateAccountV1MyAccountPost);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MyAccountApi->updateAccountV1MyAccountPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyUpdateAccountV1MyAccountPost** | [**BodyUpdateAccountV1MyAccountPost**](BodyUpdateAccountV1MyAccountPost.md)|  | [optional] 

### Return type

[**MyUser**](MyUser.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

