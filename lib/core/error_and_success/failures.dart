import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  const Failure([List properties = const <dynamic>[]]);
}

class CacheFailure extends Failure{

  final String message;

  const CacheFailure({required this.message});
  @override
  List<Object?> get props => [message];

}