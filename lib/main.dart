import 'package:expense_tracker/data/data_provider/expense_data_provider.dart';
import 'package:expense_tracker/data/repository/expense_repository.dart';
import 'package:expense_tracker/features/views/add/bloc/add_expense_bloc.dart';
import 'package:expense_tracker/features/views/add/date_bloc/date_bloc.dart';
import 'package:expense_tracker/features/views/home/bloc/expenses_bloc.dart';
import 'package:expense_tracker/features/views/home/views/home.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ExpenseRepository(ExpenseDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => ExpenseRepository(ExpenseDataProvider()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DateTimeBloc(),
          ),
          BlocProvider(
            create: (context) =>
                ExpensesBloc(context.read<ExpenseRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                AddExpenseBloc(context.read<ExpenseRepository>()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey.shade200,
          ),
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
