# openapi.model.TaskGet

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**createdOn** | [**DateTime**](DateTime.md) |  | 
**updatedOn** | [**DateTime**](DateTime.md) |  | 
**workspaceId** | **int** |  | 
**title** | **String** |  | 
**closed** | **bool** |  | [optional] [default to false]
**description** | **String** |  | [optional] 
**startDate** | [**DateTime**](DateTime.md) |  | [optional] 
**dueDate** | [**DateTime**](DateTime.md) |  | [optional] 
**assignee** | [**PersonGet**](PersonGet.md) |  | [optional] 
**author** | [**PersonGet**](PersonGet.md) |  | [optional] 
**priority** | [**PriorityGet**](PriorityGet.md) |  | [optional] 
**status** | [**StatusGet**](StatusGet.md) |  | [optional] 
**taskSource** | [**TaskSourceGet**](TaskSourceGet.md) |  | [optional] 
**tasks** | [**BuiltList&lt;TaskGet&gt;**](TaskGet.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


