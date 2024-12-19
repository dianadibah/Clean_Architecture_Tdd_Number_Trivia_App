import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_project/core/util/input_converter.dart';
import 'package:tdd_project/features/number_trivia/domain/usecases/get_concrate_numbertrivia.dart';
import 'package:tdd_project/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import '../../../../../core/constes/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/number_trivia_entiti.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;
  NumberTriviaBloc(
      {required this.getConcreteNumberTrivia,
      required this.inputConverter,
      required this.getRandomNumberTrivia})
      : super(NumberTriviaInitial());

  NumberTriviaState get initialState => Empty();
  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetConcrateNumberTriviaEvent) {
      final inputEither = inputConverter.stringToUnsignedInteger(event.number);

      yield* inputEither.fold(
        (failure) async* {
          yield const Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          
          final failureOrTrivia = await getConcreteNumberTrivia(
            Params(number: integer),
          );
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    }else if (event is GetRandomNumberTriviaEvent) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(
        NoParams(),
      );
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }
  

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> either,
  ) async* {
    yield either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
