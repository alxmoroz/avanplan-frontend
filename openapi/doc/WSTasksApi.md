# openapi.api.WSTasksApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**assignProjectMemberRoles_0**](WSTasksApi.md#assignprojectmemberroles_0) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/members/{member_id}/roles | Assign Project Member Roles
[**createInvitation_0**](WSTasksApi.md#createinvitation_0) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/invitations | Create
[**deleteNote_0**](WSTasksApi.md#deletenote_0) | **DELETE** /v1/workspaces/{ws_id}/tasks/{task_id}/notes/{note_id} | Delete
[**deleteRepeat_0**](WSTasksApi.md#deleterepeat_0) | **DELETE** /v1/workspaces/{ws_id}/tasks/{task_id}/repeats/{repeat_id} | Delete
[**deleteStatus_0**](WSTasksApi.md#deletestatus_0) | **DELETE** /v1/workspaces/{ws_id}/tasks/{task_id}/statuses/{status_id} | Delete
[**deleteTask_0**](WSTasksApi.md#deletetask_0) | **DELETE** /v1/workspaces/{ws_id}/tasks/{task_id} | Delete
[**deleteTransaction_0**](WSTasksApi.md#deletetransaction_0) | **DELETE** /v1/workspaces/{ws_id}/tasks/{task_id}/transactions/{transaction_id} | Delete
[**duplicateTask_0**](WSTasksApi.md#duplicatetask_0) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/duplicate | Duplicate
[**getInvitations_0**](WSTasksApi.md#getinvitations_0) | **GET** /v1/workspaces/{ws_id}/tasks/{task_id}/invitations | Invitations
[**moveTask_0**](WSTasksApi.md#movetask_0) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/move | Move
[**projectMemberContacts_0**](WSTasksApi.md#projectmembercontacts_0) | **GET** /v1/workspaces/{ws_id}/tasks/{task_id}/members/{member_id}/contacts | Project Member Contacts
[**repeatTask_0**](WSTasksApi.md#repeattask_0) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/repeat | Repeat
[**statusTasksCount_0**](WSTasksApi.md#statustaskscount_0) | **GET** /v1/workspaces/{ws_id}/tasks/{task_id}/statuses | Status Tasks Count
[**taskNode_0**](WSTasksApi.md#tasknode_0) | **GET** /v1/workspaces/{ws_id}/tasks/{task_id} | Task Node
[**tasksList_0**](WSTasksApi.md#taskslist_0) | **POST** /v1/workspaces/{ws_id}/tasks/list | Tasks List
[**unlinkTask_0**](WSTasksApi.md#unlinktask_0) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/unlink | Unlink
[**uploadAttachment_0**](WSTasksApi.md#uploadattachment_0) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/notes/{note_id}/attachments | Upload Attachment
[**upsertNote_0**](WSTasksApi.md#upsertnote_0) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/notes | Upsert
[**upsertRepeat_0**](WSTasksApi.md#upsertrepeat_0) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/repeats | Upsert
[**upsertStatus_0**](WSTasksApi.md#upsertstatus_0) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/statuses | Upsert
[**upsertTask_0**](WSTasksApi.md#upserttask_0) | **POST** /v1/workspaces/{ws_id}/tasks | Upsert
[**upsertTransaction_0**](WSTasksApi.md#upserttransaction_0) | **POST** /v1/workspaces/{ws_id}/tasks/{task_id}/transactions | Upsert


# **assignProjectMemberRoles_0**
> BuiltList<MemberGet> assignProjectMemberRoles_0(taskId, memberId, wsId, requestBody)

Assign Project Member Roles

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTasksApi();
final int taskId = 56; // int | 
final int memberId = 56; // int | 
final int wsId = 56; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 

try {
    final response = api.assignProjectMemberRoles_0(taskId, memberId, wsId, requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->assignProjectMemberRoles_0: $e\n');
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

# **createInvitation_0**
> InvitationGet createInvitation_0(wsId, taskId, invitation)

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

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final Invitation invitation = ; // Invitation | 

try {
    final response = api.createInvitation_0(wsId, taskId, invitation);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->createInvitation_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **invitation** | [**Invitation**](Invitation.md)|  | 

### Return type

[**InvitationGet**](InvitationGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteNote_0**
> bool deleteNote_0(wsId, noteId, taskId)

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

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int noteId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.deleteNote_0(wsId, noteId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->deleteNote_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **noteId** | **int**|  | 
 **taskId** | **int**|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteRepeat_0**
> bool deleteRepeat_0(wsId, taskId, repeatId)

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

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int repeatId = 56; // int | 

try {
    final response = api.deleteRepeat_0(wsId, taskId, repeatId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->deleteRepeat_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **repeatId** | **int**|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteStatus_0**
> bool deleteStatus_0(statusId, wsId, taskId)

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

final api = Openapi().getWSTasksApi();
final int statusId = 56; // int | 
final int wsId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.deleteStatus_0(statusId, wsId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->deleteStatus_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **statusId** | **int**|  | 
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTask_0**
> TasksChanges deleteTask_0(wsId, taskId)

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

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.deleteTask_0(wsId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->deleteTask_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 

### Return type

[**TasksChanges**](TasksChanges.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTransaction_0**
> TasksChanges deleteTransaction_0(wsId, taskId, transactionId)

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

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int transactionId = 56; // int | 

try {
    final response = api.deleteTransaction_0(wsId, taskId, transactionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->deleteTransaction_0: $e\n');
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

# **duplicateTask_0**
> TasksChanges duplicateTask_0(wsId, taskId, srcWsId, srcTaskId)

Duplicate

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int srcWsId = 56; // int | 
final int srcTaskId = 56; // int | 

try {
    final response = api.duplicateTask_0(wsId, taskId, srcWsId, srcTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->duplicateTask_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **srcWsId** | **int**|  | 
 **srcTaskId** | **int**|  | [optional] 

### Return type

[**TasksChanges**](TasksChanges.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getInvitations_0**
> BuiltList<InvitationGet> getInvitations_0(taskId, wsId, roleId)

Invitations

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTasksApi();
final int taskId = 56; // int | 
final int wsId = 56; // int | 
final int roleId = 56; // int | 

try {
    final response = api.getInvitations_0(taskId, wsId, roleId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->getInvitations_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **wsId** | **int**|  | 
 **roleId** | **int**|  | 

### Return type

[**BuiltList&lt;InvitationGet&gt;**](InvitationGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **moveTask_0**
> TasksChanges moveTask_0(wsId, taskId, srcTaskId, srcWsId)

Move

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int srcTaskId = 56; // int | 
final int srcWsId = 56; // int | 

try {
    final response = api.moveTask_0(wsId, taskId, srcTaskId, srcWsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->moveTask_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **srcTaskId** | **int**|  | 
 **srcWsId** | **int**|  | 

### Return type

[**TasksChanges**](TasksChanges.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **projectMemberContacts_0**
> BuiltList<MemberContactGet> projectMemberContacts_0(memberId, wsId, taskId)

Project Member Contacts

Способы связи участника РП в проекте

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTasksApi();
final int memberId = 56; // int | 
final int wsId = 56; // int | 
final int taskId = 56; // int | 

try {
    final response = api.projectMemberContacts_0(memberId, wsId, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->projectMemberContacts_0: $e\n');
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

# **repeatTask_0**
> TasksChanges repeatTask_0(wsId, taskId, srcWsId, srcTaskId)

Repeat

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int srcWsId = 56; // int | 
final int srcTaskId = 56; // int | 

try {
    final response = api.repeatTask_0(wsId, taskId, srcWsId, srcTaskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->repeatTask_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **srcWsId** | **int**|  | 
 **srcTaskId** | **int**|  | [optional] 

### Return type

[**TasksChanges**](TasksChanges.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **statusTasksCount_0**
> int statusTasksCount_0(wsId, taskId, projectStatusId)

Status Tasks Count

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int projectStatusId = 56; // int | 

try {
    final response = api.statusTasksCount_0(wsId, taskId, projectStatusId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->statusTasksCount_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **projectStatusId** | **int**|  | 

### Return type

**int**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **taskNode_0**
> TaskNode taskNode_0(taskId, wsId, closed, fullTree)

Task Node

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTasksApi();
final int taskId = 56; // int | 
final int wsId = 56; // int | 
final bool closed = true; // bool | 
final bool fullTree = true; // bool | 

try {
    final response = api.taskNode_0(taskId, wsId, closed, fullTree);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->taskNode_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **wsId** | **int**|  | 
 **closed** | **bool**|  | [optional] 
 **fullTree** | **bool**|  | [optional] [default to false]

### Return type

[**TaskNode**](TaskNode.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tasksList_0**
> BuiltList<TaskGet> tasksList_0(wsId, requestBody, taskId)

Tasks List

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 
final int taskId = 56; // int | 

try {
    final response = api.tasksList_0(wsId, requestBody, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->tasksList_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **requestBody** | [**BuiltList&lt;int&gt;**](int.md)|  | 
 **taskId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;TaskGet&gt;**](TaskGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unlinkTask_0**
> bool unlinkTask_0(taskId, wsId)

Unlink

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTasksApi();
final int taskId = 56; // int | 
final int wsId = 56; // int | 

try {
    final response = api.unlinkTask_0(taskId, wsId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->unlinkTask_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **wsId** | **int**|  | 

### Return type

**bool**

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadAttachment_0**
> AttachmentGet uploadAttachment_0(wsId, taskId, noteId, file)

Upload Attachment

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final int noteId = 56; // int | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.uploadAttachment_0(wsId, taskId, noteId, file);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->uploadAttachment_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **noteId** | **int**|  | 
 **file** | **MultipartFile**|  | 

### Return type

[**AttachmentGet**](AttachmentGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertNote_0**
> NoteGet upsertNote_0(wsId, taskId, noteUpsert)

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

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final NoteUpsert noteUpsert = ; // NoteUpsert | 

try {
    final response = api.upsertNote_0(wsId, taskId, noteUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->upsertNote_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **noteUpsert** | [**NoteUpsert**](NoteUpsert.md)|  | 

### Return type

[**NoteGet**](NoteGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertRepeat_0**
> TaskRepeatGet upsertRepeat_0(wsId, taskId, taskRepeatUpsert)

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

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final TaskRepeatUpsert taskRepeatUpsert = ; // TaskRepeatUpsert | 

try {
    final response = api.upsertRepeat_0(wsId, taskId, taskRepeatUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->upsertRepeat_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **taskRepeatUpsert** | [**TaskRepeatUpsert**](TaskRepeatUpsert.md)|  | 

### Return type

[**TaskRepeatGet**](TaskRepeatGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertStatus_0**
> ProjectStatusGet upsertStatus_0(wsId, taskId, projectStatusUpsert)

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

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final ProjectStatusUpsert projectStatusUpsert = ; // ProjectStatusUpsert | 

try {
    final response = api.upsertStatus_0(wsId, taskId, projectStatusUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->upsertStatus_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskId** | **int**|  | 
 **projectStatusUpsert** | [**ProjectStatusUpsert**](ProjectStatusUpsert.md)|  | 

### Return type

[**ProjectStatusGet**](ProjectStatusGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertTask_0**
> TasksChanges upsertTask_0(wsId, taskUpsert, prevPosition, nextPosition, taskId)

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

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final TaskUpsert taskUpsert = ; // TaskUpsert | 
final String prevPosition = prevPosition_example; // String | 
final String nextPosition = nextPosition_example; // String | 
final int taskId = 56; // int | 

try {
    final response = api.upsertTask_0(wsId, taskUpsert, prevPosition, nextPosition, taskId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->upsertTask_0: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 
 **taskUpsert** | [**TaskUpsert**](TaskUpsert.md)|  | 
 **prevPosition** | **String**|  | [optional] [default to '']
 **nextPosition** | **String**|  | [optional] [default to '']
 **taskId** | **int**|  | [optional] 

### Return type

[**TasksChanges**](TasksChanges.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **upsertTransaction_0**
> TasksChanges upsertTransaction_0(wsId, taskId, taskTransactionUpsert)

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

final api = Openapi().getWSTasksApi();
final int wsId = 56; // int | 
final int taskId = 56; // int | 
final TaskTransactionUpsert taskTransactionUpsert = ; // TaskTransactionUpsert | 

try {
    final response = api.upsertTransaction_0(wsId, taskId, taskTransactionUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WSTasksApi->upsertTransaction_0: $e\n');
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

