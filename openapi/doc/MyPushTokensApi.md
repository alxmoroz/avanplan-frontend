# openapi.api.MyPushTokensApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**updatePushTokenV1MyPushTokensUpdatePost**](MyPushTokensApi.md#updatepushtokenv1mypushtokensupdatepost) | **POST** /v1/my/push_tokens/update | Update Push Token


# **updatePushTokenV1MyPushTokensUpdatePost**
> bool updatePushTokenV1MyPushTokensUpdatePost(bodyUpdatePushTokenV1MyPushTokensUpdatePost)

Update Push Token

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyPushTokensApi();
final BodyUpdatePushTokenV1MyPushTokensUpdatePost bodyUpdatePushTokenV1MyPushTokensUpdatePost = ; // BodyUpdatePushTokenV1MyPushTokensUpdatePost | 

try {
    final response = api.updatePushTokenV1MyPushTokensUpdatePost(bodyUpdatePushTokenV1MyPushTokensUpdatePost);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyPushTokensApi->updatePushTokenV1MyPushTokensUpdatePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyUpdatePushTokenV1MyPushTokensUpdatePost** | [**BodyUpdatePushTokenV1MyPushTokensUpdatePost**](BodyUpdatePushTokenV1MyPushTokensUpdatePost.md)|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

