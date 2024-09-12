# openapi.api.MemberContactsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteMemberContact**](MemberContactsApi.md#deletemembercontact) | **DELETE** /v1/workspaces/{ws_id}/members/{member_id}/contacts/{member_contact_id} | Delete Contact
[**memberContacts**](MemberContactsApi.md#membercontacts) | **GET** /v1/workspaces/{ws_id}/members/{member_id}/contacts | Contacts
[**upsertMemberContact**](MemberContactsApi.md#upsertmembercontact) | **POST** /v1/workspaces/{ws_id}/members/{member_id}/contacts | Upsert Contact


# **deleteMemberContact**
> bool deleteMemberContact(memberId, memberContactId, wsId, taskId)

Delete Contact

Удаление способа связи

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMemberContactsApi();
final int memberId = 56; // int | 
final int memberContactId = 56; // int | 
final int wsId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.deleteMemberContact(memberId, memberContactId, wsId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MemberContactsApi->deleteMemberContact: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **memberId** | **int**|  | 
 **memberContactId** | **int**|  | 
 **wsId** | **int**|  | 
 **taskId** | **int**|  | [optional] 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **memberContacts**
> BuiltList<MemberContactGet> memberContacts(memberId, wsId, taskId)

Contacts

Способы связи участника РП

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMemberContactsApi();
final int memberId = 56; // int | 
final int wsId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.memberContacts(memberId, wsId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MemberContactsApi->memberContacts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **memberId** | **int**|  | 
 **wsId** | **int**|  | 
 **taskId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;MemberContactGet&gt;**](MemberContactGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertMemberContact**
> MemberContactGet upsertMemberContact(memberId, wsId, value, taskId)

Upsert Contact

Добавление / редактирование способа связи

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMemberContactsApi();
final int memberId = 56; // int | 
final int wsId = 56; // int | 
final String value = value_example; // String | 
final int taskId = 56; // int | 

try {
    final response = api.upsertMemberContact(memberId, wsId, value, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MemberContactsApi->upsertMemberContact: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **memberId** | **int**|  | 
 **wsId** | **int**|  | 
 **value** | **String**|  | 
 **taskId** | **int**|  | [optional] 

### Return type

[**MemberContactGet**](MemberContactGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

