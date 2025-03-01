# avanplan_api.model.MyUser

## Load the model package
```dart
import 'package:avanplan_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**createdOn** | [**DateTime**](DateTime.md) |  | 
**email** | **String** |  | 
**fullName** | **String** |  | [optional] 
**nickName** | **String** |  | [optional] 
**locale** | **String** |  | [optional] [default to 'ru']
**hasAvatar** | **bool** |  | [optional] 
**updatedOn** | [**DateTime**](DateTime.md) |  | [optional] 
**roleCodes** | **BuiltList&lt;String&gt;** |  | [optional] 
**permissionCodes** | **BuiltSet&lt;String&gt;** |  | [optional] 
**wsIds** | **BuiltList&lt;int&gt;** |  | [optional] 
**activities** | [**BuiltList&lt;UActivityGet&gt;**](UActivityGet.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


