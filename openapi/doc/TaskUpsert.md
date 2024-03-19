# openapi.model.TaskUpsert

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | [optional] 
**title** | **String** |  | 
**description** | **String** |  | [optional] 
**type** | **String** |  | [optional] [default to 'TASK']
**category** | **String** |  | [optional] 
**icon** | **String** |  | [optional] 
**closed** | **bool** |  | [optional] [default to false]
**startDate** | [**DateTime**](DateTime.md) |  | [optional] 
**dueDate** | [**DateTime**](DateTime.md) |  | [optional] 
**closedDate** | [**DateTime**](DateTime.md) |  | [optional] 
**estimate** | **num** |  | [optional] 
**createdOn** | [**DateTime**](DateTime.md) |  | [optional] 
**updatedOn** | [**DateTime**](DateTime.md) |  | [optional] 
**parentId** | **int** |  | [optional] 
**assigneeId** | **int** |  | [optional] 
**authorId** | **int** |  | [optional] 
**projectStatusId** | **int** |  | [optional] 
**taskSourceId** | **int** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


