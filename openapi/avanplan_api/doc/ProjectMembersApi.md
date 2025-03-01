# avanplan_api.api.ProjectMembersApi

## Load the API package
```dart
import 'package:avanplan_api/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**assignProjectMemberRoles_1**](ProjectMembersApi.md#assignprojectmemberroles_1) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/members/{member_id}/roles | Assign Project Member Roles
[**projectMemberContacts_1**](ProjectMembersApi.md#projectmembercontacts_1) | **GET** /v1/workspaces/{ws_id}/tasks/{task_id}/members/{member_id}/contacts | Project Member Contacts


# **assignProjectMemberRoles_1**
> BuiltList<MemberGet> assignProjectMemberRoles_1(taskId, memberId, wsId, requestBody)

Assign Project Member Roles

### Example
```dart
import 'package:avanplan_api/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = AvanplanApi().getProjectMembersApi();
final int taskId = 56; // int | 
final int memberId = 56; // int | 
final int wsId = 56; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 

try {
    final response = api.assignProjectMemberRoles_1(taskId, memberId, wsId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProjectMembersApi->assignProjectMemberRoles_1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **memberId** | **int**|  | 
 **wsId** | **int**|  | 
 **requestBody** | [**BuiltList&lt;int&gt;**](int.md)|  | 

### Return type

[**BuiltList&lt;MemberGet&gt;**](MemberGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **projectMemberContacts_1**
> BuiltList<MemberContactGet> projectMemberContacts_1(memberId, wsId, taskId)

Project Member Contacts

Способы связи участника РП в проекте

### Example
```dart
import 'package:avanplan_api/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = AvanplanApi().getProjectMembersApi();
final int memberId = 56; // int | 
final int wsId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.projectMemberContacts_1(memberId, wsId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProjectMembersApi->projectMemberContacts_1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **memberId** | **int**|  | 
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 

### Return type

[**BuiltList&lt;MemberContactGet&gt;**](MemberContactGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

