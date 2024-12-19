import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_project/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../core/errors/exceptions.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl(this.sharedPreferences);
  
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
  return sharedPreferences.setString(
    "CACHED_NUMBER_TRIVIA",
    json.encode(triviaToCache.toJson()),
  );
}
  
  
  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString('CACHED_NUMBER_TRIVIA');
  // Future which is immediately completed
  if (jsonString != null) {
    return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
  } else {
    throw CacheException();
  }
  }

 
}