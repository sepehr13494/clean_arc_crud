import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mc_crud_test/core/error_and_success/exeptions.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';
import 'package:mc_crud_test/core/error_and_success/succeses.dart';
import 'package:mc_crud_test/core/util/input_validator.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/create_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/delete_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/edit_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/get_users.dart';

import '../../../../core/usecases/usercase.dart';
import '../../data/data_sources/user_local_data_source.dart';
import '../../data/models/user_model.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CreateUserUseCase createUser;
  final EditUserUseCase editUser;
  final DeleteUserUseCase deleteUser;
  final GetUsersUseCase getUsers;
  final InputValidator inputValidator;

  UserBloc({
    required this.createUser,
    required this.editUser,
    required this.deleteUser,
    required this.getUsers,
    required this.inputValidator,
  }) : super(UserInitial()) {
    on<CreateUserEvent>((event, emit) async {
      try{
        await inputValidator.validateUserModel(event.userModel);
        emit(UsersLoading());
        final successOrError = await createUser(Params(userEntity: event.userModel));
        successOrError!.fold((Failure failure) {
          emit(UserError(message: failure.message));
        }, (success) {
          emit(const UserCreated(message: USER_CREATED));
        });
      } on InputValidationException catch (e){
        emit(UserError(message: e.message));
      }
    });
    on<EditUserEvent>((event, emit) async {
      try{
        await inputValidator.validateUserModel(event.userModel);
        emit(UsersLoading());
        final successOrError = await editUser(Params(userEntity: event.userModel));
        successOrError!.fold((Failure failure) {
          emit(UserError(message: failure.message));
        }, (success) {
          emit(UserEdited(message: success.message));
        });
      } on InputValidationException catch (e){
        emit(UserError(message: e.message));
      }
    });
    on<DeleteUserEvent>((event, emit) async {
      emit(UsersLoading());
      final successOrError = await deleteUser(Params(userEntity: event.userModel));
      successOrError!.fold((Failure failure) {
        emit(UserError(message: failure.message));
      }, (success) {
        emit(UserDeleted(message: success.message));
      });
    });
    on<GetUsersEvent>((event, emit) async {
      emit(UsersLoading());
      final usersOrError = await getUsers(NoParams());
      usersOrError!.fold((Failure failure) {
        emit(UserError(message: failure.message));
      }, (users) {
        emit(UsersLoaded(users: users));
      });
    });
  }
}
