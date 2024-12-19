import 'dart:convert';
import 'dart:io';

import 'package:tdd_project/core/errors/exceptions.dart';

import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcretNumerTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImp implements NumberTriviaRemoteDataSource {

  @override
  Future<NumberTriviaModel> getConcretNumerTrivia(int number) =>
      _getNumberTriviaFromUrl("http://numbersapi.com/#$number?json");

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getNumberTriviaFromUrl("http://numbersapi.com/random");

  Future<NumberTriviaModel> _getNumberTriviaFromUrl(String url) async {
    var res = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    if (res.statusCode == 200) {
      return NumberTriviaModel.fromJson(jsonDecode(res.body));
    } else {
      throw ServerException();
    }
  }
}
