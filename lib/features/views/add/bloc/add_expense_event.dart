part of 'add_expense_bloc.dart';

@immutable
sealed class AddExpenseEvent {}

class AddExpenseEventWithModel extends AddExpenseEvent {
  final ExpenseModel expenseModel;

  AddExpenseEventWithModel(this.expenseModel);
}
