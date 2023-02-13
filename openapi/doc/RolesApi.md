# openapi.api.RolesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**rolesV1RolesGet**](RolesApi.md#rolesv1rolesget) | **GET** /v1/roles/ | Roles


# **rolesV1RolesGet**
> BuiltList<RoleGet> rolesV1RolesGet(wsId)

Roles

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getRolesApi();
final int wsId = 56; // int | 

try {
    final response = api.rolesV1RolesGet(wsId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RolesApi->rolesV1RolesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wsId** | **int**|  | 

### Return type

[**BuiltList&lt;RoleGet&gt;**](RoleGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

