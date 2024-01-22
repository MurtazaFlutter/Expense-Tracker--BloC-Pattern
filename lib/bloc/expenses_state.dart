part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesState {}

final class ExpensesInitial extends ExpensesState {}

final class ExpenseSuccess extends ExpensesState {
  final List<ExpenseModel> expenseModel;

  ExpenseSuccess({required this.expenseModel});
}

final class ExpenseFailure extends ExpensesState {
  final String error;

  ExpenseFailure({required this.error});
}

final class ExpenseLoading extends ExpensesState {}

// final class AddExpenseInitial extends ExpensesState {}

// class AddExpenseSuccess extends ExpensesState {
//   final ExpenseModel expenseModel;

//   AddExpenseSuccess({required this.expenseModel});
// }

// class AddExpenseError extends ExpensesState {
//   final String error;

//   AddExpenseError(this.error);
// }

// class AddExpenseLoading extends AddExpenseState {}
