import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateTimeBloc extends Bloc<DateTimeEvent, DateTimePickerState> {
  DateTimeBloc()
      : super(
            const DateTimePickerState(selectedDate: null, selectedTime: null)) {
    on<SelectDateEvent>(_onSelectDate);
    on<SelectTimeEvent>(_onSelectTime);
  }

  void _onSelectDate(SelectDateEvent event, Emitter<DateTimePickerState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onSelectTime(SelectTimeEvent event, Emitter<DateTimePickerState> emit) {
    emit(state.copyWith(selectedTime: event.time));
  }
}
