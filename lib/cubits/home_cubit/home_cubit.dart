import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_game/cubits/home_cubit/home_state.dart';
import 'package:words_game/data/local/alphabet.dart';
import 'package:words_game/data/local/questions.dart';

class HomeCubit extends Cubit<HomeState> {
  int currentIndex = 0;
  bool isEnded = false;

  HomeCubit() : super(_initialState());

  static HomeState _initialState() {
    return const HomeState(
      shuffledLetters: [],
      image: [],
      currentQuestion: '',
      inputAnswer: "",
      errorMessage: "",
    );
  }

  void init() {
    shuffleLetters();
  }

  void shuffleLetters() {
    List<String> shuffledLetters = data[currentIndex].result.split('')
      ..shuffle();
    Random random = Random();

    var len = data[currentIndex].result.length;

    for (int i = 0; i < (12 - len); i++) {
      int randomIndex = random.nextInt(alphabet.length);
      String randomLetter = alphabet[randomIndex];
      shuffledLetters.add(randomLetter);
    }

    emit(state.copyWith(
      shuffledLetters: shuffledLetters,
      currentQuestion: data[currentIndex].result,
      image: data[currentIndex].images,
      inputAnswer: "",
      errorMessage: "",
    ));
  }

  void addLetter(String letter) {
    if (state.inputAnswer.length < data[currentIndex].result.length) {
      String inputAnswer = state.inputAnswer + letter;
      emit(state.copyWith(inputAnswer: inputAnswer));
      checkAnswer();
    }
  }

  void removeLetter(String alphabet) {
    List<String> shuffledLetters = state.shuffledLetters;
    shuffledLetters.remove(alphabet);
    emit(state.copyWith(shuffledLetters: shuffledLetters));
  }

  void removeLastLetter() {
    if (state.inputAnswer.isNotEmpty) {
      String lastAlphabet =
          state.inputAnswer.substring(state.inputAnswer.length - 1);
      String inputAnswer =
          state.inputAnswer.substring(0, state.inputAnswer.length - 1);
      List<String> shuffledLetters = state.shuffledLetters..add(lastAlphabet);
      emit(state.copyWith(
          inputAnswer: inputAnswer, shuffledLetters: shuffledLetters));
    }
  }

  void checkAnswer() async {
    if (state.inputAnswer == data[currentIndex].result) {
      nextQuestion();
    } else if (state.inputAnswer.length == data[currentIndex].result.length) {
      shuffleLetters();
    }
  }

  void restartGame() {
    currentIndex = 0;
    isEnded = false;
    shuffleLetters();
  }

  void nextQuestion() {
    if (currentIndex < data.length - 1) {
      currentIndex++;
      shuffleLetters();
    } else {
      isEnded = true;
      emit(state.copyWith(errorMessage: "Game Over!"));
    }
  }
}
