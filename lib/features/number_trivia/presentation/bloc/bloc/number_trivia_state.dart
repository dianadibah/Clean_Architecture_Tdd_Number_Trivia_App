part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {

  
  const NumberTriviaState();
  
  @override
  List<Object> get props => [];
}

final class NumberTriviaInitial extends NumberTriviaState {}
class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  const Loaded({required this.trivia});

}

class Error extends NumberTriviaState {
  final String message;

  const Error({required this.message}):super();


}
