import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTimeCubit() : super(DateTimeState());

  void updateDate(DateTime? date) {
    emit(state.copyWith(selectedDate: date));
  }

  void updateTime(TimeOfDay? time) {
    emit(state.copyWith(selectTime: time));
  }
}

class DateTimeState {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  DateTimeState({this.selectedDate, this.selectedTime});

  DateTimeState copyWith({DateTime? selectedDate, TimeOfDay? selectTime}) {
    return DateTimeState(
        selectedDate: selectedDate ?? this.selectedDate,
        selectedTime: selectTime ?? selectedTime);
  }
}
