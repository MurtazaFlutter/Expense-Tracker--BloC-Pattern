import 'package:expense_tracker/common/utils/app_consts.dart';
import 'package:expense_tracker/cubit/add_expense/add_expense_state.dart';
import 'package:expense_tracker/cubit/add_expense/expense_cubit.dart';
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
  late AddExpenseCubit _addExpenseCubit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _addExpenseCubit = AddExpenseCubit();
    super.initState();
  }

  @override
  void dispose() {
    _addExpenseCubit.close();
    super.dispose();
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      final expense = ExpenseModel(title.text, description.text, categoryValue!,
          DateTime.now(), TimeOfDay.now(), amountController.text);

      _addExpenseCubit.submitExpense(expense);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExpenseCubit, AddExpenseState>(
        builder: (context, state) {
      if (state is AddExpenseLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is AddExpenseErrorState) {
        return Center(child: Text(state.error));
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(state.error)));
      }
      if (state is AddExpenseSuccessState) {
        return Center(child: Text(state.success));
      }

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: submit,
          child: const Icon(Icons.clear),
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
    });
  }
}
