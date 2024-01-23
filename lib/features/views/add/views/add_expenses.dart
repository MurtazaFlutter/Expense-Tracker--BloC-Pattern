import 'package:expense_tracker/common/utils/app_utils.dart';
import 'package:expense_tracker/features/views/add/bloc/add_expense_bloc.dart';
import 'package:expense_tracker/features/views/add/widgets/amount_field.dart';
import 'package:expense_tracker/features/views/add/widgets/dialer_button.dart';
import 'package:expense_tracker/features/views/add/widgets/expense.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../widgets/custom_text_field.dart';

class AddExpensesScreen extends StatefulWidget {
  const AddExpensesScreen({Key? key}) : super(key: key);

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String categoryValue = 'Expense';
  final _formKey = GlobalKey<FormState>();

  void submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_areAllDetailsFilled()) {
        final expense = ExpenseModel(
            title.text,
            description.text,
            categoryValue,
            DateTime.now(),
            TimeOfDay.now(),
            amountController.text);

        context.read<AddExpenseBloc>().add(AddExpenseEventWithModel(expense));

        Navigator.of(context).pop(expense);
      } else {
        _showSnackbar("Please fill in all details");
      }
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  bool _areAllDetailsFilled() {
    return title.text.isNotEmpty &&
        description.text.isNotEmpty &&
        amountController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: submit,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Gap(20),
                CustomTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title cannot be empty';
                    } else if (value.length <= 30) {
                      return 'Title must be at most 30 characters';
                    }
                  },
                  maxLines: 1,
                  controller: title,
                  hintText: 'Title',
                ),
                const Gap(20),
                CustomTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Descirpiton can be empty';
                    } else if (value.length <= 100) {
                      return 'Description must be at most 100 characters';
                    }
                  },
                  maxLines: 3,
                  controller: description,
                  hintText: 'Description',
                ),
                const Gap(20),
                const DateTimePicker(
                  icon: Icons.date_range,
                  title: 'Date',
                ),
                const Gap(20),
                const DateTimePicker(
                  icon: Icons.alarm_add,
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
                        Text(categoryValue),
                        DropdownButton(
                          style: const TextStyle(color: Colors.black),
                          items: AppConsts.expenseCategoryDropDown,
                          onChanged: (String? value) {
                            setState(() {
                              categoryValue = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                AmountField(amountController: amountController),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    itemCount: AppConsts.payNumbers.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
      ),
    );
  }
}
