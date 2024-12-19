import 'package:flashcard_app/bloc/flashcard_bloc.dart';
import 'package:flashcard_app/flashcard_view.dart/flashcard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => FlashCardBloc(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: FlashCardScreen());
  }
}
