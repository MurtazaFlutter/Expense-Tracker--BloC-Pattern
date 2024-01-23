import 'package:flutter/material.dart';

class AppConsts {
  static const List<String> payNumbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
    'Delete'
  ];
  static const List<String> expenseCategory = ['Expense', 'Savings', 'Income'];

  static List<DropdownMenuItem<String>>? get expenseCategoryDropDown {
    List<DropdownMenuItem<String>>? menuItem =
        List<DropdownMenuItem<String>>.generate(
            expenseCategory.length,
            (index) => DropdownMenuItem(
                value: expenseCategory[index],
                child: Text(expenseCategory[index])));
    return menuItem;
  }
}
