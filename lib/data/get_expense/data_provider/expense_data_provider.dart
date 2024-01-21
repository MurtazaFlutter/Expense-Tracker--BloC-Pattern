import 'package:cloud_firestore/cloud_firestore.dart';

class ExpensesDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
