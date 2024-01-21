import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/add_expense/add_repository/add_expense_repository.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:meta/meta.dart';
part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final AddExpenseRepository addExpenseRepository;

  AddExpenseBloc(this.addExpenseRepository) : super(AddExpenseInitial()) {
    on<AddExpenseEventWithModel>(_addExpense);
  }

  void _addExpense(
    AddExpenseEventWithModel addExpenseEvent,
    Emitter<AddExpenseState> emit,
  ) async {
    emit(AddExpenseLoading());
    try {
      final expenseModel = addExpenseEvent.expenseModel;
      await addExpenseRepository.addExpense(expenseModel);
      emit(AddExpenseSuccess(expenseModel: expenseModel));
    } catch (e) {
      emit(AddExpenseError(e.toString()));
    }
  }
}
