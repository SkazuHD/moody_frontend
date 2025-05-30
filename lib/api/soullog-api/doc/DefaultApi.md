# soullog_api.api.DefaultApi

## Load the API package
```dart
import 'package:soullog_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**analyzeAnalyzePost**](DefaultApi.md#analyzeanalyzepost) | **POST** /analyze | Analyze
[**rootGet**](DefaultApi.md#rootget) | **GET** / | Root


# **analyzeAnalyzePost**
> JsonObject analyzeAnalyzePost(audio, personality)

Analyze

### Example
```dart
import 'package:soullog_api/api.dart';

final api = SoullogApi().getDefaultApi();
final MultipartFile audio = BINARY_DATA_HERE; // MultipartFile | 
final BuiltList<JsonObject> personality = ; // BuiltList<JsonObject> | 

try {
    final response = api.analyzeAnalyzePost(audio, personality);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->analyzeAnalyzePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **audio** | **MultipartFile**|  | 
 **personality** | [**BuiltList&lt;JsonObject&gt;**](JsonObject.md)|  | [optional] 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rootGet**
> JsonObject rootGet()

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

[**JsonObject**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

