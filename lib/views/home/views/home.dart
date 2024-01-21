import 'package:expense_tracker/bloc/expenses_bloc.dart';
import 'package:expense_tracker/views/add/views/add_expenses.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../widgets/expense_tracker.dart';
import '../widgets/tracker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddExpensesScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ),
              const Gap(20),
              BlocBuilder<ExpensesBloc, ExpensesState>(
                builder: (context, state) {
                  if (state is ExpenseLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ExpenseSuccess) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: PieChart(
                                  PieChartData(
                                    sections: state.expenseModel
                                        .map(
                                          (expense) => PieChartSectionData(
                                            radius: 70,
                                            color: Colors.red,
                                            value: double.parse(expense.amount),
                                            title: '\$${expense.amount}',
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: state.expenseModel
                                  .map(
                                    (expense) => Column(
                                      children: [
                                        TrackerWidget(
                                          title: expense.categoryType,
                                          color: Colors.red,
                                        ),
                                        const Gap(10),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        const Gap(20),
                        ListView.builder(
                          itemCount: state.expenseModel.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final expense = state.expenseModel[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpenseTracker(
                                category: expense.categoryType,
                                description: expense.description,
                                date: expense.date,
                                amount: double.parse(expense.amount),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is ExpenseFailure) {
                    return Text('Error: ${state.error}');
                  } else {
                    return Container();
                  }
                },
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
