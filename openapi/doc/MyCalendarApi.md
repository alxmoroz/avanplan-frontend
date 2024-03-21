# openapi.api.MyCalendarApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**myCalendarSources**](MyCalendarApi.md#mycalendarsources) | **GET** /v1/my/calendar/sources | Sources
[**myCalendarSourcesUpsert**](MyCalendarApi.md#mycalendarsourcesupsert) | **POST** /v1/my/calendar/sources | Upsert
[**myCalendarsEvents**](MyCalendarApi.md#mycalendarsevents) | **GET** /v1/my/calendar/calendars_events | Calendars Events


# **myCalendarSources**
> BuiltList<CalendarSourceGet> myCalendarSources()

Sources

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyCalendarApi();

try {
    final response = api.myCalendarSources();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MyCalendarApi->myCalendarSources: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;CalendarSourceGet&gt;**](CalendarSourceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **myCalendarSourcesUpsert**
> CalendarSourceGet myCalendarSourcesUpsert(bodyMyCalendarSourcesUpsert)

Upsert

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyCalendarApi();
final BodyMyCalendarSourcesUpsert bodyMyCalendarSourcesUpsert = ; // BodyMyCalendarSourcesUpsert | 

try {
    final response = api.myCalendarSourcesUpsert(bodyMyCalendarSourcesUpsert);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MyCalendarApi->myCalendarSourcesUpsert: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyMyCalendarSourcesUpsert** | [**BodyMyCalendarSourcesUpsert**](BodyMyCalendarSourcesUpsert.md)|  | 

### Return type

[**CalendarSourceGet**](CalendarSourceGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **myCalendarsEvents**
> CalendarsEvents myCalendarsEvents()

Calendars Events

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Openapi().getMyCalendarApi();

try {
    final response = api.myCalendarsEvents();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MyCalendarApi->myCalendarsEvents: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**CalendarsEvents**](CalendarsEvents.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader), [OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

