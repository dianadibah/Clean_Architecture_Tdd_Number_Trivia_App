import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<dynamic> proprties;

  const Failure(this.proprties);
}

class ServerFailure extends Failure {
  ServerFailure(super.proprties);
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CacheFailure extends Failure {
  CacheFailure(super.proprties);
  @override
  List<Object?> get props => throw UnimplementedError();
}
