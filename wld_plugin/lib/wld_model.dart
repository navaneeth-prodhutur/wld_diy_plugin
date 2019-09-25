import 'package:json_annotation/json_annotation.dart';
part 'wld_model.g.dart';

@JsonSerializable()
class ResponseModel {
  OperationType operationType;
  var message;
  String code;
  List<dynamic> objectsList;

  ResponseModel(this.objectsList, this.message, this.code);
  
  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}

enum OperationType {
  discover,
  connect,
  starthandshake,
  getdeviceid,
  getprovisioningstatus,
  refreshwifilist,
  connectdevicetowifi,
  enterwifipassword
}

