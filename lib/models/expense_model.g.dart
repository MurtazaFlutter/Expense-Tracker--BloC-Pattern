// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) => ExpenseModel(
      json['title'] as String,
      json['description'] as String,
      json['categoryType'] as String,
      DateTime.parse(json['date'] as String),
      ExpenseModel._timeFromJson(json['time'] as String),
      json['amount'] as String,
    );

Map<String, dynamic> _$ExpenseModelToJson(ExpenseModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'categoryType': instance.categoryType,
      'date': instance.date.toIso8601String(),
      'time': ExpenseModel._timeToJson(instance.time!),
      'amount': instance.amount
    };
