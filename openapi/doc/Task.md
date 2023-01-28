# openapi.model.Task

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **String** |  | [optional] 
**description** | **String** |  | [optional] 
**closed** | **bool** |  | [optional] [default to false]
**type** | **String** |  | [optional] [default to 'TASK']
**startDate** | [**DateTime**](DateTime.md) |  | [optional] 
**dueDate** | [**DateTime**](DateTime.md) |  | [optional] 
**closedDate** | [**DateTime**](DateTime.md) |  | [optional] 
**estimate** | **int** |  | [optional] 
**assignee** | [**Person**](Person.md) |  | [optional] 
**author** | [**Person**](Person.md) |  | [optional] 
**status** | [**Status**](Status.md) |  | [optional] 
**priority** | [**Priority**](Priority.md) |  | [optional] 
**taskSource** | [**TaskSource**](TaskSource.md) |  | [optional] 
**createdOn** | [**DateTime**](DateTime.md) |  | [optional] 
**updatedOn** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


