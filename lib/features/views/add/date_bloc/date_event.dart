part of 'date_bloc.dart';

@immutable
sealed class DateTimeEvent {}

class SelectDateEvent extends DateTimeEvent {
  final DateTime date;

  SelectDateEvent({required this.date});
}

class SelectTimeEvent extends DateTimeEvent {
  final TimeOfDay time;

  SelectTimeEvent({required this.time});
}
