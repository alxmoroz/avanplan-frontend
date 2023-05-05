# openapi.api.MyActivitiesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**activitiesV1MyActivitiesGet**](MyActivitiesApi.md#activitiesv1myactivitiesget) | **GET** /v1/my/activities | Activities
[**registerV1MyActivitiesRegisterPost**](MyActivitiesApi.md#registerv1myactivitiesregisterpost) | **POST** /v1/my/activities/register | Register


# **activitiesV1MyActivitiesGet**
> BuiltList<UActivityGet> activitiesV1MyActivitiesGet(bodyActivitiesV1MyActivitiesGet)

Activities

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyActivitiesApi();
final BodyActivitiesV1MyActivitiesGet bodyActivitiesV1MyActivitiesGet = ; // BodyActivitiesV1MyActivitiesGet | 

try {
    final response = api.activitiesV1MyActivitiesGet(bodyActivitiesV1MyActivitiesGet);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyActivitiesApi->activitiesV1MyActivitiesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyActivitiesV1MyActivitiesGet** | [**BodyActivitiesV1MyActivitiesGet**](BodyActivitiesV1MyActivitiesGet.md)|  | 

### Return type

[**BuiltList&lt;UActivityGet&gt;**](UActivityGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **registerV1MyActivitiesRegisterPost**
> bool registerV1MyActivitiesRegisterPost(bodyRegisterV1MyActivitiesRegisterPost)

Register

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyActivitiesApi();
final BodyRegisterV1MyActivitiesRegisterPost bodyRegisterV1MyActivitiesRegisterPost = ; // BodyRegisterV1MyActivitiesRegisterPost | 

try {
    final response = api.registerV1MyActivitiesRegisterPost(bodyRegisterV1MyActivitiesRegisterPost);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MyActivitiesApi->registerV1MyActivitiesRegisterPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyRegisterV1MyActivitiesRegisterPost** | [**BodyRegisterV1MyActivitiesRegisterPost**](BodyRegisterV1MyActivitiesRegisterPost.md)|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

