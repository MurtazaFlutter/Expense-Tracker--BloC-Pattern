import 'package:expense_tracker/cubit/fetch_cubit.dart';
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
  final expenseListCubit = ExpenseListCubit();

  @override
  void initState() {
    expenseListCubit.fetchExpenses();
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
              BlocBuilder<ExpenseListCubit, ExpenseListState>(
                builder: (context, state) {
                  print("state $state");
                  if (state is ExpenseListLoadingState) {
                    print("loading state $state");
                    return const CircularProgressIndicator();
                  } else if (state is ExpenseListLoadedState) {
                    print("Loaded state, expenses: ${state.expenses.length}");
                    return Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 200,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: PieChart(
                                  // Update PieChart data with state.expenses
                                  PieChartData(
                                    sections: state.expenses
                                        .map(
                                          (expense) => PieChartSectionData(
                                            radius: 70,
                                            color: Colors.red,
                                            value: double.parse(expense.amount),
                                            title: expense.amount.toString(),
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
                              children: state.expenses
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
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.expenses.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final expense = state.expenses[index];
                              print("data: $expense");
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
                        ),
                      ],
                    );
                  } else if (state is ExpenseListErrorState) {
                    print("Error state: ${state.error}");
                    return Text('Error: ${state.error}');
                  } else {
                    print("Unknown state");
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
