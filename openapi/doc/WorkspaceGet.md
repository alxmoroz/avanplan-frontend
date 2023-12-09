# openapi.model.WorkspaceGet

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**title** | **String** |  | 
**description** | **String** |  | [optional] 
**code** | **String** |  | 
**type** | **String** |  | [optional] [default to 'USER']
**users** | [**BuiltList&lt;User&gt;**](User.md) |  | [optional] 
**roles** | [**BuiltList&lt;RoleGet&gt;**](RoleGet.md) |  | [optional] 
**invoice** | [**InvoiceGet**](InvoiceGet.md) |  | [optional] 
**balance** | **num** |  | [optional] 
**mainAccount** | [**AccountGet**](AccountGet.md) |  | [optional] 
**settings** | [**SettingsGet**](SettingsGet.md) |  | [optional] 
**estimateValues** | [**BuiltList&lt;EstimateValueGet&gt;**](EstimateValueGet.md) |  | [optional] 
**sources** | [**BuiltList&lt;SourceGet&gt;**](SourceGet.md) |  | [optional] 
**tasksCount** | **int** |  | [optional] [default to 0]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


