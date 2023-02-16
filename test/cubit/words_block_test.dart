import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_your_words/config/constants.dart';
import 'package:score_your_words/logic/bloc/words_bloc.dart';

void main() {
  group("WordsBlock", () {
    late WordsBloc wordsBloc;
    const newWord = 'hello';
    final expectedWordMap = {'word': newWord, 'score': newWord.length};
    const longerWordThanLimit = "${longestWord}s";
    const expectedTotalScoreWith1Word = 5;
    const expectedTotalScoreWith2Word = 10;
    const expectedTotalScoreWith3Word = 15;

    const initialState = WordsState([
      {'word': 'apple', 'score': 5},
      {'word': 'macbook', 'score': 7},
      {'word': 'random', 'score': 6},
      {'word': 'car', 'score': 3},
    ], 21);

    setUp(() {
      wordsBloc = WordsBloc();
    });

    tearDown(() {
      wordsBloc.close();
    });

    test("the initial state for the WordsBloc is WordsState([], 0)", () {
      expect(wordsBloc.state, const WordsState([], 0));
    });

    blocTest<WordsBloc, WordsState>(
      'emits error message when new word is empty',
      build: () => wordsBloc,
      act: (bloc) => bloc.add(AddNewWordEvent('')),
      expect: () => [const WordsState([], 0, errorMessage: 'Please enter a word.')],
    );

    blocTest<WordsBloc, WordsState>(
      'emits error message when new word is longer than longest word',
      build: () => wordsBloc,
      act: (bloc) => bloc.add(AddNewWordEvent(longerWordThanLimit)),
      expect: () => [const WordsState([], 0, errorMessage: 'Word shouldn\'t be longer than: sup')],
    );

    blocTest<WordsBloc, WordsState>(
      'emits WordsState with new word added when valid AddNewWordEvent is added',
      build: () => WordsBloc(),
      act: (bloc) => bloc.add(AddNewWordEvent(newWord)),
      expect: () => [
        WordsState([expectedWordMap], expectedWordMap['score'] as int)
      ],
    );

    blocTest<WordsBloc, WordsState>(
      'emits WordsState with new word added as first value so the right value will be highlighted when valid AddNewWordEvent is added',
      build: () => WordsBloc(),
      seed: () => initialState,
      act: (bloc) => bloc.add(AddNewWordEvent(newWord)),
      expect: () => [
        WordsState(
          [expectedWordMap, ...initialState.words],
          (expectedWordMap['score'] as int) + initialState.totalScore,
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.words.first, equals(expectedWordMap));
      },
    );

    blocTest<WordsBloc, WordsState>(
      'emits WordsState with new word added when initial state has empty list',
      build: () => WordsBloc(),
      seed: () => const WordsState([], 0),
      act: (bloc) => bloc.add(AddNewWordEvent(newWord)),
      expect: () => [
        WordsState([expectedWordMap], expectedWordMap['score'] as int),
      ],
      verify: (bloc) {
        expect(bloc.state.words.first, equals(expectedWordMap));
      },
    );

    blocTest<WordsBloc, WordsState>(
      'emits multiple new words and scores when adding multiple valid words',
      build: () => wordsBloc,
      act: (bloc) {
        bloc.add(AddNewWordEvent(newWord));
        bloc.add(AddNewWordEvent(newWord));
        bloc.add(AddNewWordEvent(newWord));
      },
      expect: () => [
        WordsState([
          expectedWordMap
        ], expectedTotalScoreWith1Word),
        WordsState([
          expectedWordMap,
          expectedWordMap
        ], expectedTotalScoreWith2Word),
        WordsState([
          expectedWordMap,
          expectedWordMap,
          expectedWordMap
        ], expectedTotalScoreWith3Word),
      ],
    );

    test('calculateScore returns correct score for given word', () {
      final bloc = WordsBloc();
      int helloWordScore = 5;
      int dummyScore = 5;
      int pneumonoultramicroscopicsilicovolcanoconiosisScore = 45;
      expect(bloc.calculateScore('hello'), equals(helloWordScore));
      expect(bloc.calculateScore('dummy'), equals(dummyScore));
      expect(bloc.calculateScore('pneumonoultramicroscopicsilicovolcanoconiosis'),
          equals(pneumonoultramicroscopicsilicovolcanoconiosisScore));
    });
  });
}
