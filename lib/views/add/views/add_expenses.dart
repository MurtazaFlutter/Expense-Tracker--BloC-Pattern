import 'package:expense_tracker/bloc/bloc/add_expense_bloc.dart';
import 'package:expense_tracker/common/utils/app_consts.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/views/add/widgets/dialer_button.dart';
import 'package:expense_tracker/views/add/widgets/expense.dart';
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
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String? categoryValue;
  final _formKey = GlobalKey<FormState>();

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final expense = ExpenseModel(title.text, description.text, categoryValue!,
          DateTime.now(), TimeOfDay.now(), amountController.text);

      context.read<AddExpenseBloc>().add(AddExpenseEventWithModel(expense));

      Navigator.of(context).pop(expense);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    // if (value!.length <= 30) {
                    //   return 'Title can be less than 30';
                    // }
                  },
                  maxLines: 1,
                  controller: title,
                  hintText: 'Title',
                ),
                const Gap(20),
                CustomTextField(
                  validator: (value) {
                    // if (value!.length <= 100) {
                    //   return 'Description can be less than 100';
                    // }
                  },
                  maxLines: 3,
                  controller: description,
                  hintText: 'Description',
                ),
                const Gap(20),
                DateTimePicker(
                  icon: Icons.date_range,
                  onTap: () {},
                  title: 'Date',
                ),
                const Gap(20),
                DateTimePicker(
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
