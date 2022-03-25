part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class CreateUser extends UserEvent{
  final UserEntity userEntity;

  const CreateUser({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}

class EditUser extends UserEvent{
  final UserEntity userEntity;

  const EditUser({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}

class DeleteUser extends UserEvent{
  final UserEntity userEntity;

  const DeleteUser({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}

class GetUsers extends UserEvent{

  @override
  List<Object?> get props => [];
}
