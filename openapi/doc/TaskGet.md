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
**title** | **String** |  | [optional] 
**description** | **String** |  | [optional] 
**closed** | **bool** |  | [optional] [default to false]
**type** | **String** |  | [optional] [default to 'TASK']
**startDate** | [**DateTime**](DateTime.md) |  | [optional] 
**dueDate** | [**DateTime**](DateTime.md) |  | [optional] 
**closedDate** | [**DateTime**](DateTime.md) |  | [optional] 
**estimate** | **int** |  | [optional] 
**parentId** | **int** |  | [optional] 
**assigneeId** | **int** |  | [optional] 
**authorId** | **int** |  | [optional] 
**priorityId** | **int** |  | [optional] 
**statusId** | **int** |  | [optional] 
**taskSourceId** | **int** |  | [optional] 
**updatedOn** | [**DateTime**](DateTime.md) |  | 
**taskSource** | [**TaskSourceGet**](TaskSourceGet.md) |  | [optional] 
**members** | [**BuiltList&lt;MemberGet&gt;**](MemberGet.md) |  | [optional] 
**notes** | [**BuiltList&lt;NoteGet&gt;**](NoteGet.md) |  | [optional] 
**projectStatuses** | [**BuiltList&lt;ProjectStatusGet&gt;**](ProjectStatusGet.md) |  | [optional] 
**tasks** | [**BuiltList&lt;TaskGet&gt;**](TaskGet.md) |  | [optional] 
**state** | **String** |  | [optional] 
**leavesCount** | **int** |  | [optional] 
**openedLeavesCount** | **int** |  | [optional] 
**closedLeavesCount** | **int** |  | [optional] 
**leftPeriod** | **num** |  | [optional] 
**elapsedPeriod** | **num** |  | [optional] 
**etaPeriod** | **num** |  | [optional] 
**riskPeriod** | **num** |  | [optional] 
**isFuture** | **bool** |  | [optional] 
**etaDate** | [**DateTime**](DateTime.md) |  | [optional] 
**showSp** | **bool** |  | [optional] 
**targetVelocity** | **num** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


