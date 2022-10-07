# openapi.api.MyApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

| Method                                                                            | HTTP request              | Description         |
|-----------------------------------------------------------------------------------|---------------------------|---------------------|
| [**getMyAccountV1MyAccountGet**](MyApi.md#getmyaccountv1myaccountget)             | **GET** /v1/my/account    | Get My Account      |
| [**getMyWorkspacesV1MyWorkspacesGet**](MyApi.md#getmyworkspacesv1myworkspacesget) | **GET** /v1/my/workspaces | Get My Workspaces   |
| [**updateMyAccountV1MyAccountPut**](MyApi.md#updatemyaccountv1myaccountput)       | **PUT** /v1/my/account    | Update My Account   |


# **getMyAccountV1MyAccountGet**
> UserGet getMyAccountV1MyAccountGet()

Get My Account

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

void get () {
  final api = Openapi().getMyApi();

  try {
    final response = api.getMyAccountV1MyAccountGet();
    print(response);
  } on DioError catch (e) {
    print('Exception when calling MyApi->getMyAccountV1MyAccountGet: $e\n');
  }
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserGet**](UserGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyWorkspacesV1MyWorkspacesGet**
> BuiltList<WSUserRoleGet> getMyWorkspacesV1MyWorkspacesGet()

Get My Workspaces

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

void get () {
  final api = Openapi().getMyApi();

  try {
    final response = api.getMyWorkspacesV1MyWorkspacesGet();
    print(response);
  } on DioError catch(e) {
    print('Exception when calling MyApi->getMyWorkspacesV1MyWorkspacesGet: $e\n');
  }
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;WSUserRoleGet&gt;**](WSUserRoleGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyAccountV1MyAccountPut**
> UserGet updateMyAccountV1MyAccountPut(bodyUpdateMyAccountV1MyAccountPut)

Update My Account

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

void get() {
    final api = Openapi().getMyApi();
    final BodyUpdateMyAccountV1MyAccountPut bodyUpdateMyAccountV1MyAccountPut = build(); // BodyUpdateMyAccountV1MyAccountPut | 
    
    try {
        final response = api.updateMyAccountV1MyAccountPut(bodyUpdateMyAccountV1MyAccountPut);
        print(response);
    } on DioError catch(e)  {
        print('Exception when calling MyApi->updateMyAccountV1MyAccountPut: $e\n');
    }
}
```

### Parameters

| Name                                   | Type                                                                          | Description    | Notes      |
|----------------------------------------|-------------------------------------------------------------------------------|----------------|------------|
|  **bodyUpdateMyAccountV1MyAccountPut** | [**BodyUpdateMyAccountV1MyAccountPut**](BodyUpdateMyAccountV1MyAccountPut.md) |                | [optional] |

### Return type

[**UserGet**](UserGet.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

