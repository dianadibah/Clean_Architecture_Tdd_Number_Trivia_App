import 'package:dartz/dartz.dart';
import 'package:tdd_project/core/errors/exceptions.dart';
import 'package:tdd_project/core/errors/failures.dart';
import 'package:tdd_project/core/plateforms/network_info.dart';
import 'package:tdd_project/features/number_trivia/domain/entities/number_trivia_entiti.dart';
import 'package:tdd_project/features/number_trivia/domain/reposetories/number_trivia_repositories.dart';
import '../datasources/nuber_trivia_local_data_source.dart';
import '../datasources/number_trivia_remot_data_source.dart';

class NumberTriviaRepositoryImp implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remote;
  final NumberTriviaLocalDataSource local;
  final NetworkInfo netWorkInfo;

  NumberTriviaRepositoryImp(this.remote, this.local, this.netWorkInfo);
  
  @override
  Future<Either<Failure, NumberTrivia>> getConcretNumerTrivia(
      int number) async {
    if (await netWorkInfo.isConnected) {
      try {
        var remotenumber = await remote.getConcretNumerTrivia(number);
        return Right(remotenumber);
      } on ServerException {
        return Left(ServerFailure(const []  ));
      }
    } else {
      try {
      final localTrivia = await local.getLastNumberTrivia();
      return Right(localTrivia);
    } on CacheException {
      return Left(CacheFailure([]));
    }
    }
  }
  
  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia()async {
   if (await netWorkInfo.isConnected) {
    try {
      final remoteTrivia = await remote.getRandomNumberTrivia();
      local.cacheNumberTrivia(remoteTrivia);
      return Right(remoteTrivia);
    } on ServerException {
      return Left(ServerFailure([]));
    }
  } else {
    try {
      final localTrivia = await local.getLastNumberTrivia();
      return Right(localTrivia);
    } on CacheException {
      return Left(CacheFailure([]));
    }
  }
  }
}
