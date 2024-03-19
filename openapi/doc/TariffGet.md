# openapi.model.TariffGet

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**code** | **String** |  | 
**hidden** | **bool** |  | 
**tier** | **int** |  | 
**billingPeriodDays** | **int** |  | [optional] [default to 1]
**options** | [**BuiltList&lt;TariffOptionGet&gt;**](TariffOptionGet.md) |  | 
**limits** | [**BuiltList&lt;TariffLimitGet&gt;**](TariffLimitGet.md) |  | 
**estimateChargePerBillingPeriod** | **num** |  | [optional] [default to 0]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


