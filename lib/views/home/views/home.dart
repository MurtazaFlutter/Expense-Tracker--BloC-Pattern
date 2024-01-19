import 'package:expense_tracker/views/add/views/add_expenses.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/expense_tracker.dart';
import '../widgets/tracker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                            builder: (context) => const AddExpensesScreen()));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add")),
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(sections: [
                        PieChartSectionData(radius: 70, color: Colors.red),
                        PieChartSectionData(radius: 70, color: Colors.teal),
                        PieChartSectionData(
                            radius: 70, color: Colors.grey.shade100),
                      ]),
                    ),
                  ),
                ),
                const Gap(30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      color: Colors.grey.shade100,
                    ),
                  ],
                )
              ],
            ),
            const Gap(20),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ExpenseTracker(),
                    );
                  }),
            ),
            const Gap(20)
          ],
        ),
      ),
    ));
  }
}
