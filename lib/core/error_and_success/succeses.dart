import 'package:equatable/equatable.dart';

abstract class Success extends Equatable{
  const Success([List properties = const <dynamic>[]]);
}

class MySuccess extends Success{

  final String message;

  const MySuccess({required this.message});

  @override
  List<Object?> get props => [message];

}