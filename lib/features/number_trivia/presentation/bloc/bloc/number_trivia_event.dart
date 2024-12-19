part of 'number_trivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetConcrateNumberTriviaEvent extends NumberTriviaEvent {
  final String number;

  const GetConcrateNumberTriviaEvent(this.number);
}

class GetRandomNumberTriviaEvent extends NumberTriviaEvent {}
