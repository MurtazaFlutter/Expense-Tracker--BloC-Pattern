import 'package:expense_tracker/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DateTimePicker({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  ExpenseFlowState createState() => ExpenseFlowState();
}

class ExpenseFlowState extends State<DateTimePicker> {
  late DateTimeCubit _dateTimeCubit;

  @override
  void initState() {
    super.initState();
    _dateTimeCubit = DateTimeCubit();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _dateTimeCubit.state.selectedDate) {
      _dateTimeCubit.updateDate(pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _dateTimeCubit.state.selectedTime) {
      _dateTimeCubit.updateTime(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      bloc: _dateTimeCubit,
      builder: (context, state) {
        return Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  if (widget.title == 'Date') {
                    _selectDate(context);
                  } else if (widget.title == 'Time') {
                    _selectTime(context);
                  }
                },
                icon: Icon(
                  widget.icon,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Text(_getSelectedDateTime(state))),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getSelectedDateTime(DateTimeState state) {
    if (state.selectedDate != null && state.selectedTime != null) {
      final formattedDate = DateFormat.yMd().format(state.selectedDate!);
      final formattedTime = state.selectedTime!.format(context);
      return '$formattedDate $formattedTime';
    } else if (state.selectedDate != null) {
      return DateFormat.yMd().format(state.selectedDate!);
    } else if (state.selectedTime != null) {
      return state.selectedTime!.format(context);
    } else {
      return widget.title;
    }
  }
}
