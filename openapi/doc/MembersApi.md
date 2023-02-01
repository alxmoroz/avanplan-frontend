# openapi.api.MembersApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getTaskMembersV1MembersGet**](MembersApi.md#gettaskmembersv1membersget) | **GET** /v1/members/ | Get Task Members


# **getTaskMembersV1MembersGet**
> BuiltList<TaskMemberRoleGet> getTaskMembersV1MembersGet(taskId, wsId)

Get Task Members

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMembersApi();
final int taskId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.getTaskMembersV1MembersGet(taskId, wsId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling MembersApi->getTaskMembersV1MembersGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **wsId** | **int**|  | 

### Return type

[**BuiltList&lt;TaskMemberRoleGet&gt;**](TaskMemberRoleGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

