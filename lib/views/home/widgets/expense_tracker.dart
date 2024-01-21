import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExpenseTracker extends StatelessWidget {
  final String category;
  final String description;
  final DateTime date;
  final double amount;

  const ExpenseTracker({
    Key? key,
    required this.category,
    required this.description,
    required this.date,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shadowColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                size: 30,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category),
                Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(4),
                Text(
                  date.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Text(amount.toString()),
          ],
        ),
      ),
    );
  }
}
