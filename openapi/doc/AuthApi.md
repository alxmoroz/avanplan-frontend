# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authAppleToken**](AuthApi.md#authappletoken) | **POST** /v1/auth/apple_token | Apple Token
[**authGoogleToken**](AuthApi.md#authgoogletoken) | **POST** /v1/auth/google_token | Google Token
[**authToken**](AuthApi.md#authtoken) | **POST** /v1/auth/password_token | Password Token
[**refreshToken**](AuthApi.md#refreshtoken) | **POST** /v1/auth/refresh_token | Refresh Token
[**register**](AuthApi.md#register) | **POST** /v1/auth/register | Register


# **authAppleToken**
> Token authAppleToken(bodyAuthAppleToken)

Apple Token

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getAuthApi();
final BodyAuthAppleToken bodyAuthAppleToken = ; // BodyAuthAppleToken | 

try {
    final response = api.authAppleToken(bodyAuthAppleToken);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authAppleToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyAuthAppleToken** | [**BodyAuthAppleToken**](BodyAuthAppleToken.md)|  | 

### Return type

[**Token**](Token.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authGoogleToken**
> Token authGoogleToken(bodyAuthGoogleToken)

Google Token

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getAuthApi();
final BodyAuthGoogleToken bodyAuthGoogleToken = ; // BodyAuthGoogleToken | 

try {
    final response = api.authGoogleToken(bodyAuthGoogleToken);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authGoogleToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyAuthGoogleToken** | [**BodyAuthGoogleToken**](BodyAuthGoogleToken.md)|  | 

### Return type

[**Token**](Token.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authToken**
> Token authToken(username, password, grantType, scope, clientId, clientSecret)

Password Token

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getAuthApi();
final String username = username_example; // String | 
final String password = password_example; // String | 
final String grantType = grantType_example; // String | 
final String scope = scope_example; // String | 
final String clientId = clientId_example; // String | 
final String clientSecret = clientSecret_example; // String | 

try {
    final response = api.authToken(username, password, grantType, scope, clientId, clientSecret);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | **String**|  | 
 **password** | **String**|  | 
 **grantType** | **String**|  | [optional] 
 **scope** | **String**|  | [optional] [default to '']
 **clientId** | **String**|  | [optional] 
 **clientSecret** | **String**|  | [optional] 

### Return type

[**Token**](Token.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader)

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshToken**
> Token refreshToken()

Refresh Token

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getAuthApi();

try {
    final response = api.refreshToken();
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->refreshToken: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Token**](Token.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **register**
> Token register(bodyRegister)

Register

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getAuthApi();
final BodyRegister bodyRegister = ; // BodyRegister | 

try {
    final response = api.register(bodyRegister);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->register: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyRegister** | [**BodyRegister**](BodyRegister.md)|  | 

### Return type

[**Token**](Token.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

