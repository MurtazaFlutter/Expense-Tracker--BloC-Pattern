import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ExpenseListEvent {}

class FetchExpenseListEvent extends ExpenseListEvent {}

// States
abstract class ExpenseListState {}

class ExpenseListLoadingState extends ExpenseListState {}

class ExpenseListLoadedState extends ExpenseListState {
  final List<ExpenseModel> expenses;

  ExpenseListLoadedState(this.expenses);
}

class ExpenseListErrorState extends ExpenseListState {
  final String error;

  ExpenseListErrorState(this.error);
}

// Bloc
class ExpenseListBloc extends Bloc<ExpenseListEvent, ExpenseListState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ExpenseListBloc() : super(ExpenseListLoadingState()) {
    on<FetchExpenseListEvent>(_fetchExpenses);
  }

  void _fetchExpenses(
    FetchExpenseListEvent event,
    Emitter<ExpenseListState> emit,
  ) async {
    try {
      print("Fetching expenses...");
      final snapshot = await _firestore.collection('expenses').get();
      print("Fetched snapshot: $snapshot");

      final expenses = snapshot.docs
          .map((doc) => ExpenseModel.fromJson(doc.data()))
          .toList();

      print("Fetched expenses: $expenses");

      for (var expense in expenses) {
        print("Amount: ${expense.amount}");
      }

      emit(ExpenseListLoadedState(expenses));
    } catch (e) {
      print("Error fetching expenses: $e");
      emit(ExpenseListErrorState('Error fetching expenses: $e'));
    }
  }
}
