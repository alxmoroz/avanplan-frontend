# openapi.api.MyInvitationsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**redeemV1MyInvitationsRedeemPost**](MyInvitationsApi.md#redeemv1myinvitationsredeempost) | **POST** /v1/my/invitations/redeem | Redeem


# **redeemV1MyInvitationsRedeemPost**
> bool redeemV1MyInvitationsRedeemPost(bodyRedeemV1MyInvitationsRedeemPost)

Redeem

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyInvitationsApi();
final BodyRedeemV1MyInvitationsRedeemPost bodyRedeemV1MyInvitationsRedeemPost = ; // BodyRedeemV1MyInvitationsRedeemPost | 

try {
    final response = api.redeemV1MyInvitationsRedeemPost(bodyRedeemV1MyInvitationsRedeemPost);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MyInvitationsApi->redeemV1MyInvitationsRedeemPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyRedeemV1MyInvitationsRedeemPost** | [**BodyRedeemV1MyInvitationsRedeemPost**](BodyRedeemV1MyInvitationsRedeemPost.md)|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

