// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wld_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) {
  return ResponseModel(
    json['objectsList'] as List,
    json['message'],
    json['code'] as String,
  )..operationType =
      _$enumDecodeNullable(_$OperationTypeEnumMap, json['operationType']);
}

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'operationType': _$OperationTypeEnumMap[instance.operationType],
      'message': instance.message,
      'code': instance.code,
      'objectsList': instance.objectsList,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$OperationTypeEnumMap = {
  OperationType.discover: 'discover',
  OperationType.connect: 'connect',
  OperationType.starthandshake: 'starthandshake',
  OperationType.getdeviceid: 'getdeviceid',
  OperationType.getprovisioningstatus: 'getprovisioningstatus',
  OperationType.refreshwifilist: 'refreshwifilist',
  OperationType.connectdevicetowifi: 'connectdevicetowifi',
  OperationType.enterwifipassword: 'enterwifipassword',
};
