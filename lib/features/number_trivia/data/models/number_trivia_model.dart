class NumberTriviaModel {
  String? text;
  int? number;

  NumberTriviaModel({this.text, this.number});

  NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    NumberTriviaModel(text: json['text'], number: json['number']);
  }
  Object? toJson() {}
}
