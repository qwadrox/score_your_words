part of 'words_bloc.dart';

@immutable
abstract class WordsEvent {}

class AddNewWordEvent extends WordsEvent {
  final String newWord;
  AddNewWordEvent(this.newWord);
}