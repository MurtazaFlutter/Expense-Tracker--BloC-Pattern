import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.amountController,
  });

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: amountController,
          enabled: false,
          decoration: const InputDecoration(
            hintText: 'Amount',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
