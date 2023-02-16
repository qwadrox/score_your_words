import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/theme.dart';
import 'logic/bloc/words_bloc.dart';
import 'presentation/screens/input_ button_feedback_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Score your words',
      theme: ScoreYourWordsTheme.of(context),
      home: BlocProvider(
        create: (context) => WordsBloc(),
        child: const InputButtonFeedbackScreen(),
      ),
    );
  }
}
