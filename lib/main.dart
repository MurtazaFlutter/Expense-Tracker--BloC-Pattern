import 'package:expense_tracker/cubit/date_time_cubit.dart';
import 'package:expense_tracker/cubit/add_expense/expense_cubit.dart';
import 'package:expense_tracker/cubit/fetch_cubit.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/views/home/views/home.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DateTimeCubit(),
        ),
        BlocProvider(
          create: (context) => AddExpenseCubit(),
        ),
        BlocProvider(
          create: (context) => ExpenseListCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade200,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
