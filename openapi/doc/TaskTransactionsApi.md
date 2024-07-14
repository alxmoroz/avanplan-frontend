# openapi.api.TaskTransactionsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteTransaction**](TaskTransactionsApi.md#deletetransaction) | **DELETE** /v1/workspaces/{ws_id}/tasks/{task_id}/transactions/{transaction_id} | Delete
[**upsertTransaction**](TaskTransactionsApi.md#upserttransaction) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/transactions | Upsert


# **deleteTransaction**
> TasksChanges deleteTransaction(wsId, taskId, transactionId)

Delete

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTaskTransactionsApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int transactionId = 56; // int | 

try {
    final response = api.deleteTransaction(wsId, taskId, transactionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TaskTransactionsApi->deleteTransaction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **transactionId** | **int**|  | 

### Return type

[**TasksChanges**](TasksChanges.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertTransaction**
> TasksChanges upsertTransaction(wsId, taskId, taskTransactionUpsert)

Upsert

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getTaskTransactionsApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final TaskTransactionUpsert taskTransactionUpsert = ; // TaskTransactionUpsert | 

try {
    final response = api.upsertTransaction(wsId, taskId, taskTransactionUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TaskTransactionsApi->upsertTransaction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **taskTransactionUpsert** | [**TaskTransactionUpsert**](TaskTransactionUpsert.md)|  | 

### Return type

[**TasksChanges**](TasksChanges.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

