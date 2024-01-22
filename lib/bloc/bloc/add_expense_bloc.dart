import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/repository/expense_repository.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:meta/meta.dart';
part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final ExpenseRepository expenseRepository;

  AddExpenseBloc(this.expenseRepository) : super(AddExpenseInitial()) {
    on<AddExpenseEventWithModel>(_addExpense);
  }

  void _addExpense(
    AddExpenseEventWithModel addExpenseEvent,
    Emitter<AddExpenseState> emit,
  ) async {
    emit(AddExpenseLoading());
    try {
      final expenseModel = addExpenseEvent.expenseModel;
      await expenseRepository.addExpense(expenseModel);
      emit(AddExpenseSuccess(expenseModel: expenseModel));
    } catch (e) {
      emit(AddExpenseError(e.toString()));
    }
  }
}
