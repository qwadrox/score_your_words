part of 'words_bloc.dart';


class WordsState extends Equatable  {
  final List<Map<String, dynamic>> words;
  final int totalScore;
  final String? errorMessage;

  @override
  List<Object?> get props => [words, totalScore];

  const WordsState(this.words, this.totalScore, {this.errorMessage});
}
