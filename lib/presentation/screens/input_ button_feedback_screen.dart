import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_your_words/presentation/screens/score_your_words_screen.dart';


import '../../config/constants.dart';
import '../../config/theme.dart';
import '../../logic/bloc/words_bloc.dart';

class InputButtonFeedbackScreen extends StatefulWidget {
  const InputButtonFeedbackScreen({super.key});

  @override
  InputButtonFeedbackScreenState createState() => InputButtonFeedbackScreenState();
}

class InputButtonFeedbackScreenState extends State<InputButtonFeedbackScreen> {
  final _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      appBar: AppBar(title: const Text('Score Your Words Demo'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.score),
          tooltip: 'Score page',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                        value: wordsBloc,
                        child: const ScoreYourWordsScreen(),
                      )),
            );
          },
        ),
      ]),
      body: Padding(
        padding: AppSizes.layoutPadding,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: longestWord.length,
                      keyboardType: TextInputType.text,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(onlyEnglishCharacterRegex)),
                      ],
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: "Enter your word",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return emptyValidatorFeedback;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          wordsBloc.add(AddNewWordEvent(_textEditingController.text));
                        }
                      },
                      child: const Text("Submit"),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Text("Your words:", style: textTheme.headline1),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            BlocConsumer<WordsBloc, WordsState>(listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('New word added: ${state.words.first['word']}'),
                ),
              );
            }, builder: (context, state) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final word = state.words[index];
                    final isLatestword = index == 0;
                    return ListTile(
                      trailing: isLatestword
                          ? const Icon(
                              Icons.star,
                              color: Colors.amber,
                            )
                          : null,
                      title: Text(
                        word['word'],
                        style: isLatestword ? const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold) : textTheme.bodyText1,
                      ),
                    );
                  },
                  childCount: state.words.length,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
