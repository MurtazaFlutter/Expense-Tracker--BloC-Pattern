part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesEvent {}

//final class AddExpense extends ExpensesEvent {}

final class ExpensesFetched extends ExpensesEvent {}
