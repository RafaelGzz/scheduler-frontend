import 'package:json_annotation/json_annotation.dart';
part 'pto.g.dart';

@JsonSerializable()
class Pto {
  @JsonKey(name: "_id")
  String? id;
  int? nurseId;
  DateTime? date;
  String? status;

  Pto({this.id, this.nurseId, this.date, this.status});

  Map<String, dynamic> toJson() => _$PtoToJson(this);

  factory Pto.fromJson(Map<String, dynamic> json) =>
      _$PtoFromJson(json);
}
