# openapi.api.InvitationApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createV1InvitationCreatePost**](InvitationApi.md#createv1invitationcreatepost) | **POST** /v1/invitation/create | Create
[**redeemV1InvitationRedeemPost**](InvitationApi.md#redeemv1invitationredeempost) | **POST** /v1/invitation/redeem | Redeem


# **createV1InvitationCreatePost**
> String createV1InvitationCreatePost(wsId, invitation)

Create

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getInvitationApi();
final int wsId = 56; // int | 
final Invitation invitation = ; // Invitation | 

try {
    final response = api.createV1InvitationCreatePost(wsId, invitation);
    print(response);
} catch on DioError (e) {
    print('Exception when calling InvitationApi->createV1InvitationCreatePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **invitation** | [**Invitation**](Invitation.md)|  | 

### Return type

**String**

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **redeemV1InvitationRedeemPost**
> JsonObject redeemV1InvitationRedeemPost(url)

Redeem

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getInvitationApi();
final String url = url_example; // String | 

try {
    final response = api.redeemV1InvitationRedeemPost(url);
    print(response);
} catch on DioError (e) {
    print('Exception when calling InvitationApi->redeemV1InvitationRedeemPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **url** | **String**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

