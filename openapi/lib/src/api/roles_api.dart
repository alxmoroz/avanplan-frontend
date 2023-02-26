//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/api_util.dart';
import 'package:openapi/src/model/http_validation_error.dart';
import 'package:openapi/src/model/member_get.dart';

class RolesApi {

  final Dio _dio;

  final Serializers _serializers;

  const RolesApi(this._dio, this._serializers);

  /// Assign
  /// 
  ///
  /// Parameters:
  /// * [taskId] 
  /// * [memberId] 
  /// * [wsId] 
  /// * [requestBody] 
  /// * [permissionTaskId] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [BuiltList<MemberGet>] as data
  /// Throws [DioError] if API call or serialization fails
  Future<Response<BuiltList<MemberGet>>> assignV1RolesAssignPost({ 
    required int taskId,
    required int memberId,
    required int wsId,
    required BuiltList<int> requestBody,
    int? permissionTaskId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/roles/assign';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'oauth2',
            'name': 'OAuth2PasswordBearer',
          },
        ],
        ...?extra,
      },
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      r'task_id': encodeQueryParameter(_serializers, taskId, const FullType(int)),
      r'member_id': encodeQueryParameter(_serializers, memberId, const FullType(int)),
      r'ws_id': encodeQueryParameter(_serializers, wsId, const FullType(int)),
      if (permissionTaskId != null) r'permission_task_id': encodeQueryParameter(_serializers, permissionTaskId, const FullType(int)),
    };

    dynamic _bodyData;

    try {
      const _type = FullType(BuiltList, [FullType(int)]);
      _bodyData = _serializers.serialize(requestBody, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioError(
         requestOptions: _options.compose(
          _dio.options,
          _path,
          queryParameters: _queryParameters,
        ),
        type: DioErrorType.other,
        error: error,
      )..stackTrace = stackTrace;
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    BuiltList<MemberGet> _responseData;

    try {
      const _responseType = FullType(BuiltList, [FullType(MemberGet)]);
      _responseData = _serializers.deserialize(
        _response.data!,
        specifiedType: _responseType,
      ) as BuiltList<MemberGet>;

    } catch (error, stackTrace) {
      throw DioError(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioErrorType.other,
        error: error,
      )..stackTrace = stackTrace;
    }

    return Response<BuiltList<MemberGet>>(
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
