// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:words_game/cubits/home_cubit/home_cubit.dart';
import 'package:words_game/data/models/game_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Game', () {
    late HomeCubit gameCubit;

    final mockQuestions = [
      GameModel(images: ['question1'], result: 'answer1'),
      GameModel(images: ['question2'], result: 'answer2'),
      GameModel(images: ['question3'], result: 'answer3'),
      GameModel(images: ['question4'], result: 'answer4'),

    ];

    setUp(() {
      gameCubit = HomeCubit();
    });

    tearDown(() {
      gameCubit.close();
    });

    test('Test shuffleLetters function', () {
      HomeCubit gameCubit = HomeCubit();
      gameCubit.init();
      expect(gameCubit.state.shuffledLetters.length, 12);
    });


    test('Initial shuffleLetters', () {
      gameCubit.shuffleLetters();
      expect(gameCubit.state.shuffledLetters, hasLength(12));
    });

    test('addLetter', () {
      gameCubit.addLetter('a');
      expect(gameCubit.state.inputAnswer, 'a');
    });

    test('removeLetter', () {
      gameCubit.shuffleLetters();
      final shuffledLetters = gameCubit.state.shuffledLetters;
      gameCubit.removeLetter(shuffledLetters.first);
      expect(gameCubit.state.shuffledLetters, isNot(contains(['o', 'c', 'k', 'a', 'b', 'm', 'd', 'd', 'e', 'p', 'l'])));
    });



    test('checkAnswer - correct answer', () {
      gameCubit.addLetter('a');
      gameCubit.addLetter('n');
      gameCubit.addLetter('s');
      gameCubit.addLetter('w');
      gameCubit.addLetter('e');
      gameCubit.addLetter('r');
      gameCubit.checkAnswer();
      expect(gameCubit.state.currentQuestion, isNot(mockQuestions[0].result));
    });

    test('checkAnswer - incorrect answer', () {
      gameCubit.addLetter('x');
      gameCubit.addLetter('y');
      gameCubit.addLetter('z');
      gameCubit.checkAnswer();
      expect(gameCubit.state.currentQuestion, isNot(mockQuestions[0].result));
    });
  });
}
