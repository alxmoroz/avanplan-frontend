# openapi.api.InvitationApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createV1InvitationPost**](InvitationApi.md#createv1invitationpost) | **POST** /v1/invitation/ | Create


# **createV1InvitationPost**
> String createV1InvitationPost(wsId, invitation)

Create

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getInvitationApi();
final int wsId = 56; // int | 
final Invitation invitation = ; // Invitation | 

try {
    final response = api.createV1InvitationPost(wsId, invitation);
    print(response);
} catch on DioError (e) {
    print('Exception when calling InvitationApi->createV1InvitationPost: $e\n');
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

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

