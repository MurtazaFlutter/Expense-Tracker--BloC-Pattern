part of 'add_expense_bloc.dart';

@immutable
sealed class AddExpenseState {}

final class AddExpenseInitial extends AddExpenseState {}

class AddExpenseSuccess extends AddExpenseState {
  final ExpenseModel expenseModel;

  AddExpenseSuccess({required this.expenseModel});
}

class AddExpenseError extends AddExpenseState {
  final String error;

  AddExpenseError(this.error);
}

class AddExpenseLoading extends AddExpenseState {}
