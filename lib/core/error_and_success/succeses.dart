import 'package:equatable/equatable.dart';

abstract class Success extends Equatable{
  final String message;

  const Success({required this.message});

  @override
  List<Object?> get props => [message];

}

class MySuccess extends Success{
  const MySuccess({required String message}) : super(message: message);
}