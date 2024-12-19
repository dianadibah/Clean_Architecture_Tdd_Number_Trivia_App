import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/number_trivia_entiti.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcretNumerTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
