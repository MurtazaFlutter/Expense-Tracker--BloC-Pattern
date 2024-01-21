import 'package:expense_tracker/data/get_expense/repository/expenses_repository.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final ExpensesRepository expensesRepository;
  ExpensesBloc(this.expensesRepository) : super(ExpensesInitial()) {
    on<ExpensesFetched>((_getExpensesData));
  }

  void _getExpensesData(
      ExpensesFetched expensesFetched, Emitter<ExpensesState> emit) async {
    emit(ExpenseLoading());
    try {
      final expenses = await expensesRepository.getExpensesData();
      emit(ExpenseSuccess(expenseModel: expenses));
    } catch (e) {
      emit(ExpenseFailure(error: e.toString()));
    }
  }
}
