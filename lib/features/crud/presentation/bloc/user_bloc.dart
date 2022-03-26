import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mc_crud_test/core/error_and_success/exeptions.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';
import 'package:mc_crud_test/core/util/input_validator.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/create_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/delete_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/edit_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/get_users.dart';
import 'package:mc_crud_test/features/crud/presentation/models/create_user_obj.dart';

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
        emit(WaitForResponse());
        await inputValidator.validateUserModel(event.userModel);
        final successOrError = await createUser(Params(userEntity: UserEntity.fromCreateUserObj(event.userModel)));
        successOrError!.fold((Failure failure) {
          print(failure.message);
          emit(ResponseError(message: failure.message));
        }, (success) {
          emit(const UserCreated(message: USER_CREATED));
        });
      } on InputValidationException catch (e){
        print(e.message);
        emit(ResponseError(message: e.message));
      }
    });
    on<EditUserEvent>((event, emit) async {
      try{
        emit(WaitForResponse());
        await inputValidator.validateUserModel(event.userModel);
        final successOrError = await editUser(Params(userEntity: UserEntity.fromCreateUserObj(event.userModel)));
        successOrError!.fold((Failure failure) {
          print(failure.message);
          emit(ResponseError(message: failure.message));
        }, (success) {
          emit(UserEdited(message: success.message));
        });
      } on InputValidationException catch (e){
        print(e.message);
        emit(ResponseError(message: e.message));
      }
    });
    on<DeleteUserEvent>((event, emit) async {
      emit(WaitForResponse());
      final successOrError = await deleteUser(Params(userEntity: event.userModel));
      successOrError!.fold((Failure failure) {
        print(failure.message);
        emit(ResponseError(message: failure.message));
      }, (success) {
        emit(UserDeleted(message: success.message));
      });
    });
    on<GetUsersEvent>((event, emit) async {
      emit(UsersLoading());
      final usersOrError = await getUsers(NoParams());
      usersOrError!.fold((Failure failure) {
        print(failure.message);
        emit(UserError(message: failure.message));
      }, (users) {
        emit(UsersLoaded(users: users));
      });
    });
  }
}
