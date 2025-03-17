# avanplan_api.model.TaskGet

## Load the model package
```dart
import 'package:avanplan_api/api.dart';
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
**relations** | [**BuiltList&lt;TaskRelationGet&gt;**](TaskRelationGet.md) |  | [optional] [default to ListBuilder()]
**relationsCount** | **int** |  | [optional] 
**repeat** | [**TaskRepeatGet**](TaskRepeatGet.md) |  | [optional] 
**repeatsCount** | **int** |  | [optional] 
**taskSource** | [**TaskSourceGet**](TaskSourceGet.md) |  | [optional] 
**members** | [**BuiltList&lt;MemberGet&gt;**](MemberGet.md) |  | [optional] [default to ListBuilder()]
**notes** | [**BuiltList&lt;NoteGet&gt;**](NoteGet.md) |  | [optional] [default to ListBuilder()]
**notesCount** | **int** |  | [optional] 
**attachments** | [**BuiltList&lt;AttachmentGet&gt;**](AttachmentGet.md) |  | [optional] [default to ListBuilder()]
**attachmentsCount** | **int** |  | [optional] 
**projectStatuses** | [**BuiltList&lt;ProjectStatusGet&gt;**](ProjectStatusGet.md) |  | [optional] [default to ListBuilder()]
**settings** | [**BuiltList&lt;TaskSettingsGet&gt;**](TaskSettingsGet.md) |  | [optional] [default to ListBuilder()]
**transactions** | [**BuiltList&lt;TaskTransactionGet&gt;**](TaskTransactionGet.md) |  | [optional] [default to ListBuilder()]
**subtasksCount** | **int** |  | [optional] 
**position** | **String** |  | [optional] 
**hasSubgroups** | **bool** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


