import 'package:json_annotation/json_annotation.dart';
part 'time_frame.g.dart';

@JsonSerializable()
class TimeFrame {
  DateTime? start;
  DateTime? end;

  TimeFrame({this.start, this.end});

  Map<String, dynamic> toJson() => _$TimeFrameToJson(this);

  factory TimeFrame.fromJson(Map<String, dynamic> json) =>
      _$TimeFrameFromJson(json);
}
