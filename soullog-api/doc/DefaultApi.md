# soullog_api.api.DefaultApi

## Load the API package
```dart
import 'package:soullog_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**analyzeAudio**](DefaultApi.md#analyzeaudio) | **POST** /analyze | Analyze audio diary entry
[**emojiCheckin**](DefaultApi.md#emojicheckin) | **POST** /emoji_checkin | Emoji mood check-in
[**rootGet**](DefaultApi.md#rootget) | **GET** / | Root


# **analyzeAudio**
> AnalyzeResponse analyzeAudio(audio, personality)

Analyze audio diary entry

Transcribe audio, detect mood, and update user persona based on the transcript.

### Example
```dart
import 'package:soullog_api/api.dart';

final api = SoullogApi().getDefaultApi();
final MultipartFile audio = BINARY_DATA_HERE; // MultipartFile | 
final String personality = personality_example; // String | 

try {
    final response = api.analyzeAudio(audio, personality);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->analyzeAudio: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **audio** | **MultipartFile**|  | 
 **personality** | **String**|  | [optional] 

### Return type

[**AnalyzeResponse**](AnalyzeResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **emojiCheckin**
> AnalyzeResponse emojiCheckin(mood, personality)

Emoji mood check-in

Generate recommendations and a quote based on selected mood.

### Example
```dart
import 'package:soullog_api/api.dart';

final api = SoullogApi().getDefaultApi();
final String mood = mood_example; // String | 
final String personality = personality_example; // String | 

try {
    final response = api.emojiCheckin(mood, personality);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->emojiCheckin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mood** | **String**|  | 
 **personality** | **String**|  | [optional] 

### Return type

[**AnalyzeResponse**](AnalyzeResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rootGet**
> BuiltMap<String, JsonObject> rootGet()

Root

### Example
```dart
import 'package:soullog_api/api.dart';

final api = SoullogApi().getDefaultApi();

try {
    final response = api.rootGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->rootGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

