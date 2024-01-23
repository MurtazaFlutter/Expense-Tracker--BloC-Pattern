import 'package:flutter/material.dart';

class DialerButton extends StatelessWidget {
  final String label;
  final int index;
  final IconData? icon;
  final VoidCallback onPressed;

  const DialerButton({
    Key? key,
    required this.label,
    required this.index,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: index == 10 ? Colors.red : Colors.white,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: index == 10 ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
