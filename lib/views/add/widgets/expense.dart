import 'package:expense_tracker/bloc/date_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final IconData icon;
  final String title;

  const DateTimePicker({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  ExpenseFlowState createState() => ExpenseFlowState();
}

class ExpenseFlowState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeBloc, DateTimePickerState>(
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
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Text(_getSelectedDateTime(state)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getSelectedDateTime(DateTimePickerState state) {
    // Implement logic to format and display the selected date and time
    if (widget.title == 'Date') {
      return state.selectedDate != null
          ? DateFormat('dd MMM yyyy').format(state.selectedDate!)
          : 'Select Date';
    } else if (widget.title == 'Time') {
      return state.selectedTime != null
          ? DateFormat('hh:mm a').format(
              DateTime(0, 1, 1, state.selectedTime!.hour,
                  state.selectedTime!.minute),
            )
          : 'Select Time';
    } else {
      return 'Invalid Type';
    }
  }

  void _selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      if (!context.mounted) return;
      context.read<DateTimeBloc>().add(SelectDateEvent(date: selectedDate));
    }
  }

  void _selectTime(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      if (!context.mounted) return;
      context.read<DateTimeBloc>().add(SelectTimeEvent(time: selectedTime));
    }
  }
}
