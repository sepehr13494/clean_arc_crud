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
import '../../data/models/user_model.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CreateUserUseCase createUser;
  final EditUserUseCase editUser;
  final DeleteUserUseCase deleteUser;
  final GetUsersUseCase getUsers;
  final InputValidatorImpl inputValidatorImpl;

  final String onCreateUser = "User Created SuccessFully!";

  UserBloc({
    required this.createUser,
    required this.editUser,
    required this.deleteUser,
    required this.getUsers,
    required this.inputValidatorImpl,
  }) : super(UserInitial()) {
    on<CreateUserEvent>((event, emit) async {
      emit(UsersLoading());
      try{
        await _validatePhoneAndEmail(event.userModel);
        final successOrError = await createUser(Params(userEntity: event.userModel));
        successOrError!.fold((Failure failure) {
          emit(UserError(message: failure.message));
        }, (success) {
          emit(UserCreated(message: onCreateUser));
        });
      } on InputValidationException catch (e){
        emit(UserError(message: e.message));
      }
    });
    on<EditUserEvent>((event, emit) async {
      emit(UsersLoading());
      final successOrError = await editUser(Params(userEntity: event.userModel));
      successOrError!.fold((Failure failure) {
        emit(UserError(message: failure.message));
      }, (success) {
        emit(UserEdited(message: success.message));
      });
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

  Future<void> _validatePhoneAndEmail(UserModel userModel) async{
    Map<String, dynamic> json = userModel.toJson();
    json.forEach((key, value) {
      if(key != "id"){
        if(value == null || value.toString().trim().isEmpty){
          throw InputValidationException(message: "Please fill all fields");
        }
      }
    });
    bool phoneValid = await inputValidatorImpl.validatePhoneNumber(phoneNumber: userModel.phoneNumber, isoCode: userModel.isoCode);
    if(!phoneValid){
      throw InputValidationException(message: "Invalid Phone Number");
    }
    bool emailValid = await inputValidatorImpl.validateEmail(email: userModel.email);
    if(emailValid){
      throw InputValidationException(message: "Invalid email");
    }

    bool bankAccountValid = await inputValidatorImpl.validateBankAccount(bankAccount: userModel.bankAccountNumber);
    if(bankAccountValid){
      throw InputValidationException(message: "Invalid bank account");
    }
  }
}
