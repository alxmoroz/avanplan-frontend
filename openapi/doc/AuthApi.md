# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authToken**](AuthApi.md#authtoken) | **POST** /v1/auth/token | Token
[**authTokenGoogleOauth**](AuthApi.md#authtokengoogleoauth) | **POST** /v1/auth/token_google_oauth | Token Google Oauth


# **authToken**
> Token authToken(username, password, grantType, scope, clientId, clientSecret)

Token

### Example
```dart
import 'package:openapi/api.dart';

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

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authTokenGoogleOauth**
> Token authTokenGoogleOauth(bodyAuthTokenGoogleOauth)

Token Google Oauth

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final BodyAuthTokenGoogleOauth bodyAuthTokenGoogleOauth = ; // BodyAuthTokenGoogleOauth | 

try {
    final response = api.authTokenGoogleOauth(bodyAuthTokenGoogleOauth);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authTokenGoogleOauth: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyAuthTokenGoogleOauth** | [**BodyAuthTokenGoogleOauth**](BodyAuthTokenGoogleOauth.md)|  | 

### Return type

[**Token**](Token.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

