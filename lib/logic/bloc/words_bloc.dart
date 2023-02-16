import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:score_your_words/config/constants.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc() : super(const WordsState([], 0)) {
    on<AddNewWordEvent>(handleAddNewWordEvent);
  }

  FutureOr<void> handleAddNewWordEvent(event, emit) {
    if (event.newWord.isEmpty) {
      emit(WordsState(state.words, state.totalScore, errorMessage: "Please enter a word."));
    }else if (event.newWord.length > longestWord.length){
      emit(WordsState(state.words, state.totalScore, errorMessage: "Word shouldn't be longer than: $longestWord."));
    }else {
    final Map<String, dynamic> newWord = {'word': event.newWord, 'score': calculateScore(event.newWord)};
    final newWords = [newWord, ...state.words];
    final totalScore = state.totalScore + newWord['score'] as int;
    emit(WordsState(newWords, totalScore));}
  }

  int calculateScore(String word) {
    return word.length;
  }
}
