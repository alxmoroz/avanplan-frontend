# openapi.api.Deprecated11Api

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deprecatedInvitationCreateV1InvitationPost**](Deprecated11Api.md#deprecatedinvitationcreatev1invitationpost) | **POST** /v1/invitation | Deprecated Invitation Create
[**deprecatedRolesAssignV1RolesPost**](Deprecated11Api.md#deprecatedrolesassignv1rolespost) | **POST** /v1/roles | Deprecated Roles Assign


# **deprecatedInvitationCreateV1InvitationPost**
> String deprecatedInvitationCreateV1InvitationPost(wsId, invitation)

Deprecated Invitation Create

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getDeprecated11Api();
final int wsId = 56; // int | 
final Invitation invitation = ; // Invitation | 

try {
    final response = api.deprecatedInvitationCreateV1InvitationPost(wsId, invitation);
    print(response);
} catch on DioError (e) {
    print('Exception when calling Deprecated11Api->deprecatedInvitationCreateV1InvitationPost: $e\n');
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

# **deprecatedRolesAssignV1RolesPost**
> BuiltList<MemberGet> deprecatedRolesAssignV1RolesPost(taskId, memberId, wsId, requestBody, permissionTaskId)

Deprecated Roles Assign

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getDeprecated11Api();
final int taskId = 56; // int | 
final int memberId = 56; // int | 
final int wsId = 56; // int | 
final BuiltList<int> requestBody = ; // BuiltList<int> | 
final int permissionTaskId = 56; // int | 

try {
    final response = api.deprecatedRolesAssignV1RolesPost(taskId, memberId, wsId, requestBody, permissionTaskId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling Deprecated11Api->deprecatedRolesAssignV1RolesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **int**|  | 
 **memberId** | **int**|  | 
 **wsId** | **int**|  | 
 **requestBody** | [**BuiltList&lt;int&gt;**](int.md)|  | 
 **permissionTaskId** | **int**|  | [optional] 

### Return type

[**BuiltList&lt;MemberGet&gt;**](MemberGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

