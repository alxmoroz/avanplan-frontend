//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_settings_get.g.dart';

/// AppSettingsGet
///
/// Properties:
/// * [id] 
/// * [frontendFlags] 
/// * [wsOwnerRoleId] 
/// * [welcomeGiftAmount] 
/// * [lowStartThresholdDays] 
/// * [riskThresholdDays] 
/// * [estimateReliabilityDays] 
/// * [estimateReliabilityClosedRatioThreshold] 
/// * [estimateAvgDefault] 
@BuiltValue()
abstract class AppSettingsGet implements Built<AppSettingsGet, AppSettingsGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'frontend_flags')
  String? get frontendFlags;

  @BuiltValueField(wireName: r'ws_owner_role_id')
  int? get wsOwnerRoleId;

  @BuiltValueField(wireName: r'welcome_gift_amount')
  int? get welcomeGiftAmount;

  @BuiltValueField(wireName: r'low_start_threshold_days')
  int? get lowStartThresholdDays;

  @BuiltValueField(wireName: r'risk_threshold_days')
  int? get riskThresholdDays;

  @BuiltValueField(wireName: r'estimate_reliability_days')
  int? get estimateReliabilityDays;

  @BuiltValueField(wireName: r'estimate_reliability_closed_ratio_threshold')
  num? get estimateReliabilityClosedRatioThreshold;

  @BuiltValueField(wireName: r'estimate_avg_default')
  num? get estimateAvgDefault;

  AppSettingsGet._();

  factory AppSettingsGet([void updates(AppSettingsGetBuilder b)]) = _$AppSettingsGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AppSettingsGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AppSettingsGet> get serializer => _$AppSettingsGetSerializer();
}

class _$AppSettingsGetSerializer implements PrimitiveSerializer<AppSettingsGet> {
  @override
  final Iterable<Type> types = const [AppSettingsGet, _$AppSettingsGet];

  @override
  final String wireName = r'AppSettingsGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AppSettingsGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    if (object.frontendFlags != null) {
      yield r'frontend_flags';
      yield serializers.serialize(
        object.frontendFlags,
        specifiedType: const FullType(String),
      );
    }
    if (object.wsOwnerRoleId != null) {
      yield r'ws_owner_role_id';
      yield serializers.serialize(
        object.wsOwnerRoleId,
        specifiedType: const FullType(int),
      );
    }
    if (object.welcomeGiftAmount != null) {
      yield r'welcome_gift_amount';
      yield serializers.serialize(
        object.welcomeGiftAmount,
        specifiedType: const FullType(int),
      );
    }
    if (object.lowStartThresholdDays != null) {
      yield r'low_start_threshold_days';
      yield serializers.serialize(
        object.lowStartThresholdDays,
        specifiedType: const FullType(int),
      );
    }
    if (object.riskThresholdDays != null) {
      yield r'risk_threshold_days';
      yield serializers.serialize(
        object.riskThresholdDays,
        specifiedType: const FullType(int),
      );
    }
    if (object.estimateReliabilityDays != null) {
      yield r'estimate_reliability_days';
      yield serializers.serialize(
        object.estimateReliabilityDays,
        specifiedType: const FullType(int),
      );
    }
    if (object.estimateReliabilityClosedRatioThreshold != null) {
      yield r'estimate_reliability_closed_ratio_threshold';
      yield serializers.serialize(
        object.estimateReliabilityClosedRatioThreshold,
        specifiedType: const FullType(num),
      );
    }
    if (object.estimateAvgDefault != null) {
      yield r'estimate_avg_default';
      yield serializers.serialize(
        object.estimateAvgDefault,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AppSettingsGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AppSettingsGetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'frontend_flags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.frontendFlags = valueDes;
          break;
        case r'ws_owner_role_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.wsOwnerRoleId = valueDes;
          break;
        case r'welcome_gift_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.welcomeGiftAmount = valueDes;
          break;
        case r'low_start_threshold_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lowStartThresholdDays = valueDes;
          break;
        case r'risk_threshold_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.riskThresholdDays = valueDes;
          break;
        case r'estimate_reliability_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.estimateReliabilityDays = valueDes;
          break;
        case r'estimate_reliability_closed_ratio_threshold':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.estimateReliabilityClosedRatioThreshold = valueDes;
          break;
        case r'estimate_avg_default':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.estimateAvgDefault = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AppSettingsGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppSettingsGetBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

