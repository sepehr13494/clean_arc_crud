part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserEvent extends UserEvent{
  final UserModel userModel;

  const CreateUserEvent({required this.userModel});
}

class EditUserEvent extends UserEvent{
  final UserModel userModel;

  const EditUserEvent({required this.userModel});
}

class UserEditedEvent extends UserEvent{}

class DeleteUserEvent extends UserEvent{
  final UserModel userModel;

  const DeleteUserEvent({required this.userModel});
}

class GetUsersEvent extends UserEvent{}

