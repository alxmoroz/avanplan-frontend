# openapi.api.PaymentsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ymPaymentNotificationV1PaymentsYmPaymentNotificationPost**](PaymentsApi.md#ympaymentnotificationv1paymentsympaymentnotificationpost) | **POST** /v1/payments/ym/payment_notification | Ym Payment Notification


# **ymPaymentNotificationV1PaymentsYmPaymentNotificationPost**
> JsonObject ymPaymentNotificationV1PaymentsYmPaymentNotificationPost(notificationType, operationId, amount, withdrawAmount, currency, datetime, sender, codepro, sha1Hash, label, unaccepted)

Ym Payment Notification

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPaymentsApi();
final String notificationType = notificationType_example; // String | 
final String operationId = operationId_example; // String | 
final String amount = amount_example; // String | 
final String withdrawAmount = withdrawAmount_example; // String | 
final String currency = currency_example; // String | 
final String datetime = datetime_example; // String | 
final String sender = sender_example; // String | 
final String codepro = codepro_example; // String | 
final String sha1Hash = sha1Hash_example; // String | 
final String label = label_example; // String | 
final bool unaccepted = true; // bool | 

try {
    final response = api.ymPaymentNotificationV1PaymentsYmPaymentNotificationPost(notificationType, operationId, amount, withdrawAmount, currency, datetime, sender, codepro, sha1Hash, label, unaccepted);
    print(response);
} catch on DioError (e) {
    print('Exception when calling PaymentsApi->ymPaymentNotificationV1PaymentsYmPaymentNotificationPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **notificationType** | **String**|  | [optional] [default to '']
 **operationId** | **String**|  | [optional] [default to '']
 **amount** | **String**|  | [optional] [default to '']
 **withdrawAmount** | **String**|  | [optional] [default to '']
 **currency** | **String**|  | [optional] [default to '']
 **datetime** | **String**|  | [optional] [default to '']
 **sender** | **String**|  | [optional] [default to '']
 **codepro** | **String**|  | [optional] [default to '']
 **sha1Hash** | **String**|  | [optional] [default to '']
 **label** | **String**|  | [optional] [default to '0']
 **unaccepted** | **bool**|  | [optional] [default to false]

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

