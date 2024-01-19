import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/expense_tracker.dart';
import '../widgets/tracker.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Gap(20),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton.icon(
                  onPressed: () {},
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
                        PieChartSectionData(radius: 70, color: Colors.grey),
                      ]),
                    ),
                  ),
                ),
                const Gap(30),
                Column(
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
                      color: Colors.grey.shade200,
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
