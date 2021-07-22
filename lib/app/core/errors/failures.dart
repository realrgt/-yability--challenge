import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  final String? message;

  CacheFailure({this.message});
}
