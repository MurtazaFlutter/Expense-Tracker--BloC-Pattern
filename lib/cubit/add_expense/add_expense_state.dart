// States
abstract class AddExpenseState {}

class AddExpenseInitialState extends AddExpenseState {}

class AddExpenseLoadingState extends AddExpenseState {}

class AddExpenseSuccessState extends AddExpenseState {
  final String success;

  AddExpenseSuccessState(this.success);
}

class AddExpenseErrorState extends AddExpenseState {
  final String error;

  AddExpenseErrorState(this.error);
}
