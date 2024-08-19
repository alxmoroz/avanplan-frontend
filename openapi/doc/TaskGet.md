# openapi.model.TaskGet

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
**type** | **String** |  | [optional] [default to 'TASK']
**category** | **String** |  | [optional] 
**icon** | **String** |  | [optional] 
**closed** | **bool** |  | [optional] [default to false]
**startDate** | [**DateTime**](DateTime.md) |  | [optional] 
**dueDate** | [**DateTime**](DateTime.md) |  | [optional] 
**closedDate** | [**DateTime**](DateTime.md) |  | [optional] 
**estimate** | **num** |  | [optional] 
**createdOn** | [**DateTime**](DateTime.md) |  | 
**updatedOn** | [**DateTime**](DateTime.md) |  | 
**parentId** | **int** |  | [optional] 
**assigneeId** | **int** |  | [optional] 
**authorId** | **int** |  | [optional] 
**projectStatusId** | **int** |  | [optional] 
**taskSourceId** | **int** |  | [optional] 
**state** | **String** |  | [optional] 
**velocity** | **num** |  | [optional] 
**requiredVelocity** | **num** |  | [optional] 
**progress** | **num** |  | [optional] 
**etaDate** | [**DateTime**](DateTime.md) |  | [optional] 
**openedVolume** | **num** |  | [optional] 
**closedVolume** | **num** |  | [optional] 
**closedSubtasksCount** | **int** |  | [optional] 
**income** | **num** |  | [optional] [default to 0.0]
**expenses** | **num** |  | [optional] [default to 0.0]
**repeat** | [**TaskRepeatGet**](TaskRepeatGet.md) |  | [optional] 
**taskSource** | [**TaskSourceGet**](TaskSourceGet.md) |  | [optional] 
**members** | [**BuiltList&lt;MemberGet&gt;**](MemberGet.md) |  | [optional] 
**notes** | [**BuiltList&lt;NoteGet&gt;**](NoteGet.md) |  | [optional] 
**attachments** | [**BuiltList&lt;AttachmentGet&gt;**](AttachmentGet.md) |  | [optional] 
**projectStatuses** | [**BuiltList&lt;ProjectStatusGet&gt;**](ProjectStatusGet.md) |  | [optional] 
**projectModules** | [**BuiltList&lt;ProjectModuleGet&gt;**](ProjectModuleGet.md) |  | [optional] 
**transactions** | [**BuiltList&lt;TaskTransactionGet&gt;**](TaskTransactionGet.md) |  | [optional] 
**notesCount** | **int** |  | [optional] 
**attachmentsCount** | **int** |  | [optional] 
**subtasksCount** | **int** |  | [optional] 
**repeatsCount** | **int** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


