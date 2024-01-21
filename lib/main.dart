import 'package:expense_tracker/bloc/bloc/add_expense_bloc.dart';
import 'package:expense_tracker/bloc/expenses_bloc.dart';
import 'package:expense_tracker/cubit/date_time_cubit.dart';
import 'package:expense_tracker/data/add_expense/add_expense_provider.dart';
import 'package:expense_tracker/data/get_expense/data_provider/expense_data_provider.dart';
import 'package:expense_tracker/data/get_expense/repository/expenses_repository.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/views/home/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/add_expense/add_repository/add_expense_repository.dart';

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
          create: (context) => ExpensesRepository(ExpensesDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => AddExpenseRepository(AddExpenseDataProvider()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DateTimeCubit(),
          ),
          BlocProvider(
            create: (context) =>
                ExpensesBloc(context.read<ExpensesRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                AddExpenseBloc(context.read<AddExpenseRepository>()),
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
