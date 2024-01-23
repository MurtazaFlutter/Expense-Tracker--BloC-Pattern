import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ExpenseTracker extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final DateTime date;
  final String amount;

  const ExpenseTracker(
      {Key? key,
      required this.title,
      required this.description,
      required this.date,
      required this.amount,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine arrow icon and color based on income or expense
    IconData icon;
    Color iconColor;
    if (category == 'Income') {
      icon = Icons.arrow_forward;
      iconColor = Colors.teal;
    } else if (category == 'Expense') {
      icon = Icons.arrow_back;
      iconColor = Colors.red;
    } else {
      // Default to a neutral arrow icon and color
      icon = Icons.arrow_forward;
      iconColor = Colors.black;
    }
    print('Title: $title');

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: iconColor,
              ),
            ),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const Gap(4),
                  Text(
                    'Date: ${DateFormat('dd MMM yyyy').format(date)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Time: ${DateFormat('hh:mm a').format(date)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(amount),
          ],
        ),
      ),
    );
  }
}
