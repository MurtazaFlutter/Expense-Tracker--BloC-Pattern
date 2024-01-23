import 'package:expense_tracker/features/views/add/views/add_expenses.dart';
import 'package:expense_tracker/features/views/home/bloc/expenses_bloc.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../widgets/expense_tracker.dart';
import '../widgets/tracker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double getTotalAmount(List<ExpenseModel> expenseModel) {
    return expenseModel
        .map((expense) => double.parse(expense.amount))
        .reduce((a, b) => a + b);
  }

  double totalAmount = 0.0;

  @override
  void initState() {
    context.read<ExpensesBloc>().add(ExpensesFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const Gap(20),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final newExpense = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddExpensesScreen(),
                      ),
                    );

                    if (newExpense != null && context.mounted) {
                      context.read<ExpensesBloc>().add(ExpensesFetched());
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ),
              const Gap(20),
              Expanded(
                child: FractionallySizedBox(
                  heightFactor: 1.1,
                  child: BlocBuilder<ExpensesBloc, ExpensesState>(
                    builder: (context, state) {
                      if (state is ExpenseLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ExpenseSuccess) {
                        if (state.expenseModel.isEmpty) {
                          return const Center(
                            child: Text(
                              'No entries yet. Add new entries using the "Add" button.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: PieChart(
                                        PieChartData(
                                          sections: List.generate(
                                            state.expenseModel.length,
                                            (index) {
                                              final expense =
                                                  state.expenseModel[index];
                                              final totalAmount =
                                                  getTotalAmount(
                                                      state.expenseModel);
                                              return PieChartSectionData(
                                                showTitle: false,
                                                value: (double.parse(
                                                            expense.amount) /
                                                        totalAmount) *
                                                    100,
                                                color: getColorForCategory(
                                                    expense.categoryType),
                                                radius: 100,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(30),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TrackerWidget(
                                        title: 'Expense',
                                        color: Colors.red,
                                      ),
                                      const Gap(10),
                                      const TrackerWidget(
                                        title: 'Income',
                                        color: Colors.teal,
                                      ),
                                      const Gap(10),
                                      TrackerWidget(
                                        title: 'Saving',
                                        color: Colors.grey.shade300,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Gap(20),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: state.expenseModel.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final expense = state.expenseModel[index];

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ExpenseTracker(
                                        title: expense.title,
                                        description: expense.description,
                                        date: expense.date,
                                        amount: expense.amount,
                                        category: expense.categoryType,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      } else if (state is ExpenseFailure) {
                        return Text('Error: ${state.error}');
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }

  Color getColorForCategory(String categoryType) {
    switch (categoryType) {
      case 'Income':
        return Colors.teal;
      case 'Savings':
        return Colors.grey.shade300;
      case 'Expense':
        return Colors.red;
      default:
        return Colors.red;
    }
  }
}
