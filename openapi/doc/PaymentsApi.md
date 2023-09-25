# openapi.api.PaymentsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**iapNotificationV1PaymentsIapNotificationPost**](PaymentsApi.md#iapnotificationv1paymentsiapnotificationpost) | **POST** /v1/payments/iap/notification | Iap Notification


# **iapNotificationV1PaymentsIapNotificationPost**
> num iapNotificationV1PaymentsIapNotificationPost(wsId, bodyIapNotificationV1PaymentsIapNotificationPost)

Iap Notification

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getPaymentsApi();
final int wsId = 56; // int | 
final BodyIapNotificationV1PaymentsIapNotificationPost bodyIapNotificationV1PaymentsIapNotificationPost = ; // BodyIapNotificationV1PaymentsIapNotificationPost | 

try {
    final response = api.iapNotificationV1PaymentsIapNotificationPost(wsId, bodyIapNotificationV1PaymentsIapNotificationPost);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PaymentsApi->iapNotificationV1PaymentsIapNotificationPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **bodyIapNotificationV1PaymentsIapNotificationPost** | [**BodyIapNotificationV1PaymentsIapNotificationPost**](BodyIapNotificationV1PaymentsIapNotificationPost.md)|  | 

### Return type

**num**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

