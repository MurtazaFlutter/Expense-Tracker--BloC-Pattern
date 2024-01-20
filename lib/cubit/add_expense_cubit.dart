// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AddExpensesCubit extends Cubit<AddExpensesState> {
//   AddExpensesCubit() : super(AddExpensesState.initial());

//   String? _title;
//   String? _description;
//   String? _category;
//   String? _amount;
//   DateTime? _date;
//   TimeOfDay? _time;

//   void setTitle(String title) {
//     _title = title;
//     emit(AddExpensesTitleChanged(title: title));
//   }

//   void setDescription(String description) {
//     _description = description;
//     emit(AddExpensesDescriptionChanged(description: description));
//   }

//   void setCategory(String category) {
//     _category = category;
//     emit(AddExpensesCategoryChanged(category: category));
//   }

//   void setAmount(String amount) {
//     _amount = amount;
//     emit(AddExpensesAmountChanged(amount: amount));
//   }

//   void setDate(DateTime? date) {
//     _date = date;
//     emit(AddExpensesDateChanged(date: date));
//   }

//   void setTime(TimeOfDay? time) {
//     _time = time;
//     emit(AddExpensesTimeChanged(time: time));
//   }

//   void submit() {
//     if (_title == null || _title!.isEmpty) {
//       emit(AddExpensesValidationError(
//         field: AddExpensesValidationField.title,
//         message: 'Please provide a title.',
//       ));
//       return;
//     }

//     if (_description == null || _description!.isEmpty) {
//       emit(AddExpensesValidationError(
//         field: AddExpensesValidationField.description,
//         message: 'Please provide a description.',
//       ));
//       return;
//     }

//     if (_category == null || _category!.isEmpty) {
//       emit(AddExpensesValidationError(
//         field: AddExpensesValidationField.category,
//         message: 'Please select a category.',
//       ));
//       return;
//     }

//     if (_amount == null || _amount!.isEmpty) {
//       emit(AddExpensesValidationError(
//         field: AddExpensesValidationField.amount,
//         message: 'Please provide an amount.',
//       ));
//       return;
//     }

//     if (_date == null) {
//       emit(AddExpensesValidationError(
//         field: AddExpensesValidationField.date,
//         message: 'Please select a date.',
//       ));
//       return;
//     }

//     if (_time == null) {
//       emit(AddExpensesValidationError(
//         field: AddExpensesValidationField.time,
//         message: 'Please select a time.',
//       ));
//       return;
//     }

//     // Continue with form submission
//     emit(AddExpensesSubmit());
//   }
// }

// enum AddExpensesValidationField {
//   title,
//   description,
//   category,
//   amount,
//   date,
//   time,
// }

// abstract class AddExpensesState {}

// class AddExpensesValidationError extends AddExpensesState {
//   final AddExpensesValidationField field;
//   final String message;

//   AddExpensesValidationError({
//     required this.field,
//     required this.message,
//   });
// }
