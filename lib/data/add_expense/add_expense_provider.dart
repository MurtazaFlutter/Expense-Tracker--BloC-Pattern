import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/expense_model.dart';

class AddExpenseDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addExpense(ExpenseModel expenseModel) async {
    try {
      _firestore.collection('expenses').add(expenseModel.toJson());
    } catch (e) {
      throw (e.toString());
    }
  }
}
