import 'package:expense_tracker/common/utils/app_consts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../widgets/custom_text_field.dart';

class AddExpensesScreen extends StatefulWidget {
  const AddExpensesScreen({Key? key}) : super(key: key);

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String? categoryValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.clear),
      ),
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const Gap(20),
              CustomTextField(
                validator: (value) {},
                maxLines: 1,
                controller: title,
                hintText: 'Title',
              ),
              const Gap(20),
              CustomTextField(
                validator: (value) {},
                maxLines: 5,
                controller: description,
                hintText: 'Description',
              ),
              const Gap(20),
              ExpenseFlow(
                icon: Icons.date_range,
                onTap: () {},
                title: 'Date',
              ),
              const Gap(20),
              ExpenseFlow(
                icon: Icons.alarm_add,
                onTap: () {},
                title: 'Time',
              ),
              const Gap(20),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(categoryValue ?? 'Expense'),
                      DropdownButton(
                        style: const TextStyle(color: Colors.black),
                        items: AppConsts.expenseCategoryDropDown,
                        onChanged: (String? value) {
                          setState(() {
                            categoryValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: amountController,
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'Amount',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: AppConsts.payNumbers.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.7,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DialerButton(
                        index: index,
                        label: AppConsts.payNumbers[index],
                        onPressed: () {
                          setState(() {
                            if (index == 10) {
                              amountController.clear();
                            } else {
                              amountController.text +=
                                  AppConsts.payNumbers[index];
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DialerButton extends StatelessWidget {
  final String label;
  final int index;
  final IconData? icon;
  final VoidCallback onPressed;

  const DialerButton({
    Key? key,
    required this.label,
    required this.index,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: index == 10 ? Colors.red : Colors.white,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: index == 10 ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class ExpenseFlow extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ExpenseFlow({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  _ExpenseFlowState createState() => _ExpenseFlowState();
}

class _ExpenseFlowState extends State<ExpenseFlow> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(_getSelectedDateTime()),
            ),
          ),
        ),
      ],
    );
  }

  String _getSelectedDateTime() {
    if (selectedDate != null && selectedTime != null) {
      final formattedDate = DateFormat.yMd().format(selectedDate!);
      final formattedTime = selectedTime!.format(context);
      return '$formattedDate $formattedTime';
    } else if (selectedDate != null) {
      return DateFormat.yMd().format(selectedDate!);
    } else if (selectedTime != null) {
      return selectedTime!.format(context);
    } else {
      return widget.title;
    }
  }
}
