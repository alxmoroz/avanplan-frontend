# openapi.model.WorkspaceGet

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**title** | **String** |  | [optional] 
**description** | **String** |  | [optional] 
**users** | [**BuiltList&lt;User&gt;**](User.md) |  | [optional] [default to ListBuilder()]
**roles** | [**BuiltList&lt;RoleGet&gt;**](RoleGet.md) |  | [optional] [default to ListBuilder()]
**invoice** | [**InvoiceGet**](InvoiceGet.md) |  | [optional] 
**balance** | **num** |  | [optional] 
**settings** | [**SettingsGet**](SettingsGet.md) |  | [optional] 
**estimateValues** | [**BuiltList&lt;EstimateValueGet&gt;**](EstimateValueGet.md) |  | [optional] [default to ListBuilder()]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


