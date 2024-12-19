import 'package:dartz/dartz.dart';
import 'package:tdd_project/core/errors/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return const Left(InvalidInputFailure([]));
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.proprties);

  @override
  List<Object?> get props => throw UnimplementedError();
}
