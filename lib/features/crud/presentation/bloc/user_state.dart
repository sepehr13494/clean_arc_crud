part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UsersLoading extends UserState{}

class UsersLoaded extends UserState{
  final List<UserEntity> users;

  const UsersLoaded({required this.users});
}

class UserError extends UserState{
  final String message;
  final Function? reload;

  const UserError({required this.message,this.reload});
}

class WaitForResponse extends UserState{}

class ResponseError extends UserState{
  final String message;

  const ResponseError({required this.message});

}

abstract class SuccessfullyDoneState extends UserState{
  final String message;

  const SuccessfullyDoneState({required this.message});
}

class UserCreated extends SuccessfullyDoneState{
  const UserCreated({required String message}) : super(message: message);
}

class UserEdited extends SuccessfullyDoneState{
  const UserEdited({required String message}) : super(message: message);
}

class UserDeleted extends SuccessfullyDoneState{
  const UserDeleted({required String message}) : super(message: message);
}

