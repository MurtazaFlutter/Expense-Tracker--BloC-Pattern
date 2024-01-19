import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({
    super.key,
  });

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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                const Text("Salary Deposit"),
                const Text(
                  "My office salary has been \ndeposited for the month of July",
                ),
                const Gap(4),
                Text(
                  "${DateTime.now().toLocal()}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Text("20,0000"),
          ]),
        ));
  }
}
