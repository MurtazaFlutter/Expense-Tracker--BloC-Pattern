part of 'date_bloc.dart';

@immutable
class DateTimePickerState {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  const DateTimePickerState({
    required this.selectedDate,
    required this.selectedTime,
  });

  DateTimePickerState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
  }) {
    return DateTimePickerState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }
}
