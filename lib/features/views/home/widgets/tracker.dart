import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TrackerWidget extends StatelessWidget {
  final String title;
  final Color color;

  const TrackerWidget({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const Gap(10),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
