import 'package:expense_tracker/data/add_expense/add_expense_provider.dart';
import 'package:expense_tracker/models/expense_model.dart';

class AddExpenseRepository {
  final AddExpenseDataProvider addExpenseDataProvider;

  AddExpenseRepository(this.addExpenseDataProvider);

  Future addExpense(ExpenseModel expenseModel) async {
    try {
      addExpenseDataProvider.addExpense(expenseModel);
    } catch (e) {
      throw e.toString();
    }
  }
}
