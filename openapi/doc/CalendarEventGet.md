# openapi.model.CalendarEventGet

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **String** |  | 
**description** | **String** |  | [optional] 
**calendarId** | **int** |  | 
**startDate** | [**DateTime**](DateTime.md) |  | 
**endDate** | [**DateTime**](DateTime.md) |  | 
**allDay** | **bool** |  | [optional] [default to false]
**location** | **String** |  | [optional] 
**attendees** | [**BuiltList&lt;CalendarEventAttendee&gt;**](CalendarEventAttendee.md) |  | [optional] [default to ListBuilder()]
**sourceCode** | **String** |  | [optional] 
**sourceLink** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


