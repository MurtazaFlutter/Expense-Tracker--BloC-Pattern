import 'package:expense_tracker/cubit/date_time_cubit.dart';
import 'package:expense_tracker/views/home/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DateTimeCubit(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade200,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
