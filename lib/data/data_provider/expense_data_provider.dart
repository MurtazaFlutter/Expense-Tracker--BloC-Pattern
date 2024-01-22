import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpenseDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addExpense(ExpenseModel expenseModel) async {
    try {
      _firestore.collection('expenses').add(expenseModel.toJson());
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getExpenses() async {
    try {
      final snapshot = await _firestore.collection('expenses').get();

      return snapshot.docs;
    } catch (e) {
      throw (e.toString());
    }
  }
}
