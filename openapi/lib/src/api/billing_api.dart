//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:built_value/json_object.dart';
import 'package:openapi/src/api_util.dart';
import 'package:openapi/src/model/http_validation_error.dart';

class BillingApi {

  final Dio _dio;

  final Serializers _serializers;

  const BillingApi(this._dio, this._serializers);

  /// Ym Payment Notification
  /// 
  ///
  /// Parameters:
  /// * [notificationType] 
  /// * [operationId] 
  /// * [amount] 
  /// * [withdrawAmount] 
  /// * [currency] 
  /// * [datetime] 
  /// * [sender] 
  /// * [codepro] 
  /// * [sha1Hash] 
  /// * [label] 
  /// * [unaccepted] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [JsonObject] as data
  /// Throws [DioError] if API call or serialization fails
  Future<Response<JsonObject>> ymPaymentNotificationV1BillingYmPaymentNotificationPost({ 
    String? notificationType,
    String? operationId,
    String? amount,
    String? withdrawAmount,
    String? currency,
    String? datetime,
    String? sender,
    String? codepro,
    String? sha1Hash,
    String? label,
    bool? unaccepted,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/billing/ym/payment_notification';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      contentType: 'application/x-www-form-urlencoded',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = <String, dynamic>{
        if (notificationType != null) r'notification_type': encodeQueryParameter(_serializers, notificationType, const FullType(String)),
        if (operationId != null) r'operation_id': encodeQueryParameter(_serializers, operationId, const FullType(String)),
        if (amount != null) r'amount': encodeQueryParameter(_serializers, amount, const FullType(String)),
        if (withdrawAmount != null) r'withdraw_amount': encodeQueryParameter(_serializers, withdrawAmount, const FullType(String)),
        if (currency != null) r'currency': encodeQueryParameter(_serializers, currency, const FullType(String)),
        if (datetime != null) r'datetime': encodeQueryParameter(_serializers, datetime, const FullType(String)),
        if (sender != null) r'sender': encodeQueryParameter(_serializers, sender, const FullType(String)),
        if (codepro != null) r'codepro': encodeQueryParameter(_serializers, codepro, const FullType(String)),
        if (sha1Hash != null) r'sha1_hash': encodeQueryParameter(_serializers, sha1Hash, const FullType(String)),
        if (label != null) r'label': encodeQueryParameter(_serializers, label, const FullType(String)),
        if (unaccepted != null) r'unaccepted': encodeQueryParameter(_serializers, unaccepted, const FullType(bool)),
      };

    } catch(error, stackTrace) {
      throw DioError(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioErrorType.other,
        error: error,
      )..stackTrace = stackTrace;
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    JsonObject _responseData;

    try {
      const _responseType = FullType(JsonObject);
      _responseData = _serializers.deserialize(
        _response.data!,
        specifiedType: _responseType,
      ) as JsonObject;

    } catch (error, stackTrace) {
      throw DioError(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioErrorType.other,
        error: error,
      )..stackTrace = stackTrace;
    }

    return Response<JsonObject>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

}
