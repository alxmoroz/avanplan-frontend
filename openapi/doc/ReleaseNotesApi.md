# openapi.api.ReleaseNotesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to */api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**releaseNotes**](ReleaseNotesApi.md#releasenotes) | **GET** /v1/release_notes | Release Notes


# **releaseNotes**
> BuiltList<ReleaseNoteGet> releaseNotes(oldVersion)

Release Notes

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';

final api = Openapi().getReleaseNotesApi();
final String oldVersion = oldVersion_example; // String | 

try {
    final response = api.releaseNotes(oldVersion);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReleaseNotesApi->releaseNotes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **oldVersion** | **String**|  | 

### Return type

[**BuiltList&lt;ReleaseNoteGet&gt;**](ReleaseNoteGet.md)

### Authorization

[APIKeyHeader](../README.md#APIKeyHeader)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

