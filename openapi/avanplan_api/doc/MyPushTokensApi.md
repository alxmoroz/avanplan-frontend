# avanplan_api.api.MyPushTokensApi

## Load the API package
```dart
import 'package:avanplan_api/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**updatePushTokenV1MyPushTokensPost**](MyPushTokensApi.md#updatepushtokenv1mypushtokenspost) | **POST** /v1/my/push_tokens | Update Push Token


# **updatePushTokenV1MyPushTokensPost**
> bool updatePushTokenV1MyPushTokensPost(bodyUpdatePushTokenV1MyPushTokensPost)

Update Push Token

### Example
```dart
import 'package:avanplan_api/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = AvanplanApi().getMyPushTokensApi();
final BodyUpdatePushTokenV1MyPushTokensPost bodyUpdatePushTokenV1MyPushTokensPost = ; // BodyUpdatePushTokenV1MyPushTokensPost | 

try {
    final response = api.updatePushTokenV1MyPushTokensPost(bodyUpdatePushTokenV1MyPushTokensPost);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MyPushTokensApi->updatePushTokenV1MyPushTokensPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyUpdatePushTokenV1MyPushTokensPost** | [**BodyUpdatePushTokenV1MyPushTokensPost**](BodyUpdatePushTokenV1MyPushTokensPost.md)|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

