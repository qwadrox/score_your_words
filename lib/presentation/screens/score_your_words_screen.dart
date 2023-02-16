import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../config/theme.dart';
import '../../logic/bloc/words_bloc.dart';

class ScoreYourWordsScreen extends StatefulWidget {
  const ScoreYourWordsScreen({super.key});

  @override
  ScoreYourWordsScreenState createState() => ScoreYourWordsScreenState();
}

class ScoreYourWordsScreenState extends State<ScoreYourWordsScreen> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wordsBloc = context.read<WordsBloc>();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Score Your Words 2nd screen')),
      body: Padding(
        padding: AppSizes.layoutPadding,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  Text("Your total score: ${wordsBloc.state.totalScore}", style: textTheme.headline2,),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text("Word list:", style: textTheme.headline1),
                    ],
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final wordMap = wordsBloc.state.words[index];
                  return ListTile(
                    title: Text(
                      "${wordMap['word']} score: ${wordMap['score']} ",
                      style: textTheme.bodyText1,
                    ),
                  );
                },
                childCount: wordsBloc.state.words.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
