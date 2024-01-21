// Events
import 'package:expense_tracker/models/expense_model.dart';

abstract class AddExpenseEvent {}

class SubmitExpenseEvent extends AddExpenseEvent {
  final ExpenseModel expense;

  SubmitExpenseEvent(this.expense);
}
