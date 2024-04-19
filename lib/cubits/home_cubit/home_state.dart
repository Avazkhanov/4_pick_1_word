class HomeState {
  final List<String> shuffledLetters;
  final String currentQuestion;
  final String inputAnswer;
  final String errorMessage;
  final List<String> image;

  const HomeState( {
    required this.shuffledLetters,
    required this.currentQuestion,
    required this.inputAnswer,
    required this.errorMessage,
    required this.image,
  });

  HomeState copyWith({
    List<String>? shuffledLetters,
    String? currentQuestion,
    String? inputAnswer,
    String? errorMessage,
    List<String>? image,
  }) {
    return HomeState(
      shuffledLetters: shuffledLetters ?? this.shuffledLetters,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      inputAnswer: inputAnswer ?? this.inputAnswer,
      errorMessage: errorMessage ?? this.errorMessage,
      image: image ?? this.image,
    );
  }
}
