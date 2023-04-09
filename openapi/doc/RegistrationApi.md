# openapi.api.RegistrationApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createV1RegistrationCreatePost**](RegistrationApi.md#createv1registrationcreatepost) | **POST** /v1/registration/create | Create
[**redeemV1RegistrationRedeemPost**](RegistrationApi.md#redeemv1registrationredeempost) | **POST** /v1/registration/redeem | Redeem


# **createV1RegistrationCreatePost**
> bool createV1RegistrationCreatePost(bodyCreateV1RegistrationCreatePost)

Create

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getRegistrationApi();
final BodyCreateV1RegistrationCreatePost bodyCreateV1RegistrationCreatePost = ; // BodyCreateV1RegistrationCreatePost | 

try {
    final response = api.createV1RegistrationCreatePost(bodyCreateV1RegistrationCreatePost);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RegistrationApi->createV1RegistrationCreatePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyCreateV1RegistrationCreatePost** | [**BodyCreateV1RegistrationCreatePost**](BodyCreateV1RegistrationCreatePost.md)|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **redeemV1RegistrationRedeemPost**
> Token redeemV1RegistrationRedeemPost(bodyRedeemV1RegistrationRedeemPost)

Redeem

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getRegistrationApi();
final BodyRedeemV1RegistrationRedeemPost bodyRedeemV1RegistrationRedeemPost = ; // BodyRedeemV1RegistrationRedeemPost | 

try {
    final response = api.redeemV1RegistrationRedeemPost(bodyRedeemV1RegistrationRedeemPost);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RegistrationApi->redeemV1RegistrationRedeemPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyRedeemV1RegistrationRedeemPost** | [**BodyRedeemV1RegistrationRedeemPost**](BodyRedeemV1RegistrationRedeemPost.md)|  | 

### Return type

[**Token**](Token.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

