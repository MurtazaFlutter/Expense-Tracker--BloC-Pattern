import 'package:expense_tracker/data/get_expense/data_provider/expense_data_provider.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpensesRepository {
  final ExpensesDataProvider expensesDataProvider;

  ExpensesRepository(this.expensesDataProvider);

  Future<List<ExpenseModel>> getExpensesData() async {
    try {
      final expensesData = await expensesDataProvider.getExpenses();

      // Assuming expensesData is a List<QueryDocumentSnapshot>
      final List<ExpenseModel> expenses = expensesData.map((snapshot) {
        // Convert each snapshot to a Map<String, dynamic> and then to ExpenseModel
        return ExpenseModel.fromJson(snapshot.data());
      }).toList();

      return expenses;
    } catch (e) {
      throw (e.toString());
    }
  }
}
