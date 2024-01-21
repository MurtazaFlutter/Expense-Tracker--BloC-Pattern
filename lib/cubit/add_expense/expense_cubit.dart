import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/cubit/add_expense/add_expense_state.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit
class AddExpenseCubit extends Cubit<AddExpenseState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AddExpenseCubit() : super(AddExpenseInitialState());

  void submitExpense(ExpenseModel expense) async {
    emit(AddExpenseLoadingState());

    try {
      // Save data to Firestore

      await _firestore.collection('expenses').add(expense.toJson());

      emit(AddExpenseSuccessState("Expense added"));
    } catch (e) {
      emit(AddExpenseErrorState('Error submitting expense: $e'));
    }
  }
}
