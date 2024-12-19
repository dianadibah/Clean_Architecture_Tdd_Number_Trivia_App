import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_project/core/util/input_converter.dart';
import 'package:tdd_project/features/number_trivia/data/datasources/nuber_trivia_local_data_source.dart';
import 'package:tdd_project/features/number_trivia/data/datasources/number_trivia_remot_data_source.dart';
import 'package:tdd_project/features/number_trivia/data/repositories/number_trivia_repository_data.dart';
import 'package:tdd_project/features/number_trivia/domain/reposetories/number_trivia_repositories.dart';
import 'package:tdd_project/features/number_trivia/domain/usecases/get_concrate_numbertrivia.dart';
import 'package:tdd_project/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_project/features/number_trivia/presentation/bloc/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      inputConverter: sl(),
      getRandomNumberTrivia: sl()));
//! UseCases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));
//! Core
  sl.registerLazySingleton(() => InputConverter());

//! Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImp(sl(), sl(), sl()));
//! Datasource
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImp());
  var sharedprf = await SharedPreferences.getInstance();
//! SharedPreferance
  sl.registerLazySingleton<SharedPreferences>(() => sharedprf);
  
}
