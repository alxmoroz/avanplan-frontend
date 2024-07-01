//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/u_activity_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'my_user.g.dart';

/// MyUser
///
/// Properties:
/// * [id] 
/// * [createdOn] 
/// * [email] 
/// * [fullName] 
/// * [nickName] 
/// * [locale] 
/// * [hasAvatar] 
/// * [updatedOn] 
/// * [roleCodes] 
/// * [permissionCodes] 
/// * [wsIds] 
/// * [activities] 
@BuiltValue()
abstract class MyUser implements Built<MyUser, MyUserBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'created_on')
  DateTime get createdOn;

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'full_name')
  String? get fullName;

  @BuiltValueField(wireName: r'nick_name')
  String? get nickName;

  @BuiltValueField(wireName: r'locale')
  String? get locale;

  @BuiltValueField(wireName: r'has_avatar')
  bool? get hasAvatar;

  @BuiltValueField(wireName: r'updated_on')
  DateTime? get updatedOn;

  @BuiltValueField(wireName: r'role_codes')
  BuiltList<String>? get roleCodes;

  @BuiltValueField(wireName: r'permission_codes')
  BuiltList<String>? get permissionCodes;

  @BuiltValueField(wireName: r'ws_ids')
  BuiltList<int>? get wsIds;

  @BuiltValueField(wireName: r'activities')
  BuiltList<UActivityGet> get activities;

  MyUser._();

  factory MyUser([void updates(MyUserBuilder b)]) = _$MyUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MyUserBuilder b) => b
      ..locale = 'ru';

  @BuiltValueSerializer(custom: true)
  static Serializer<MyUser> get serializer => _$MyUserSerializer();
}

class _$MyUserSerializer implements PrimitiveSerializer<MyUser> {
  @override
  final Iterable<Type> types = const [MyUser, _$MyUser];

  @override
  final String wireName = r'MyUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MyUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'created_on';
    yield serializers.serialize(
      object.createdOn,
      specifiedType: const FullType(DateTime),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    if (object.fullName != null) {
      yield r'full_name';
      yield serializers.serialize(
        object.fullName,
        specifiedType: const FullType(String),
      );
    }
    if (object.nickName != null) {
      yield r'nick_name';
      yield serializers.serialize(
        object.nickName,
        specifiedType: const FullType(String),
      );
    }
    if (object.locale != null) {
      yield r'locale';
      yield serializers.serialize(
        object.locale,
        specifiedType: const FullType(String),
      );
    }
    if (object.hasAvatar != null) {
      yield r'has_avatar';
      yield serializers.serialize(
        object.hasAvatar,
        specifiedType: const FullType(bool),
      );
    }
    if (object.updatedOn != null) {
      yield r'updated_on';
      yield serializers.serialize(
        object.updatedOn,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.roleCodes != null) {
      yield r'role_codes';
      yield serializers.serialize(
        object.roleCodes,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.permissionCodes != null) {
      yield r'permission_codes';
      yield serializers.serialize(
        object.permissionCodes,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.wsIds != null) {
      yield r'ws_ids';
      yield serializers.serialize(
        object.wsIds,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
    yield r'activities';
    yield serializers.serialize(
      object.activities,
      specifiedType: const FullType(BuiltList, [FullType(UActivityGet)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MyUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MyUserBuilder result,
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
        case r'created_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdOn = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'full_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fullName = valueDes;
          break;
        case r'nick_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nickName = valueDes;
          break;
        case r'locale':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.locale = valueDes;
          break;
        case r'has_avatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasAvatar = valueDes;
          break;
        case r'updated_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedOn = valueDes;
          break;
        case r'role_codes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.roleCodes.replace(valueDes);
          break;
        case r'permission_codes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.permissionCodes.replace(valueDes);
          break;
        case r'ws_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.wsIds.replace(valueDes);
          break;
        case r'activities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(UActivityGet)]),
          ) as BuiltList<UActivityGet>;
          result.activities.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MyUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MyUserBuilder();
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

