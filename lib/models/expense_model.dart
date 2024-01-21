import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'expense_model.g.dart';

@JsonSerializable()
class ExpenseModel {
  final String title;
  final String description;
  final String categoryType;
  final DateTime date;
  final String amount;

  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final TimeOfDay? time;

  ExpenseModel(this.title, this.description, this.categoryType, this.date,
      this.time, this.amount);

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);

  static TimeOfDay _timeFromJson(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static String _timeToJson(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }
}
