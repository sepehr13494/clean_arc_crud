import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/core/error_and_success/exeptions.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';
import 'package:mc_crud_test/core/error_and_success/succeses.dart';
import 'package:mc_crud_test/core/util/input_validator.dart';
import 'package:mc_crud_test/features/crud/data/data_sources/user_local_data_source.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/create_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/delete_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/edit_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/get_users.dart';
import 'package:mc_crud_test/features/crud/presentation/bloc/user_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_bloc_test.mocks.dart';

@GenerateMocks([CreateUserUseCase])
@GenerateMocks([EditUserUseCase])
@GenerateMocks([DeleteUserUseCase])
@GenerateMocks([GetUsersUseCase])
@GenerateMocks([InputValidatorImpl])
void main() {
  late MockCreateUserUseCase mockCreateUserUseCase;
  late MockEditUserUseCase mockEditUserUseCase;
  late MockDeleteUserUseCase mockDeleteUserUseCase;
  late MockGetUsersUseCase mockGetUsersUseCase;
  late MockInputValidatorImpl mockInputValidatorImpl;

  late UserBloc userBloc;

  final tUser = UserModel.userModelForTest;
  const tMessage = "message";


  setUp(() {
    mockCreateUserUseCase = MockCreateUserUseCase();
    mockEditUserUseCase = MockEditUserUseCase();
    mockDeleteUserUseCase = MockDeleteUserUseCase();
    mockGetUsersUseCase = MockGetUsersUseCase();
    mockInputValidatorImpl = MockInputValidatorImpl();

    userBloc = UserBloc(
      createUser: mockCreateUserUseCase,
      editUser: mockEditUserUseCase,
      deleteUser: mockDeleteUserUseCase,
      getUsers: mockGetUsersUseCase,
      inputValidator: mockInputValidatorImpl,
    );
  });

  test('initialState should be UserInitial', () async {
    //assert
    expect(userBloc.state, equals(UserInitial()));
  });

  void throwExceptionFromValidator() {
    //arrange
    when(mockInputValidatorImpl.validateUserModel(any)).thenThrow(InputValidationException(message: tMessage));
    //assert later
    final expected = [const UserError(message: tMessage)];
    expectLater(userBloc.stream, emitsInOrder(expected));
  }

  group('CreateUserEvent', () {

    const tInt = 1;

    test(
      'should call the inputValidator with no exception when all data is valid',
      () async {
        when(mockCreateUserUseCase(any)).thenAnswer((realInvocation) async => const Right(tInt));
        //act
        userBloc.add(CreateUserEvent(userModel: tUser));
        await untilCalled(mockInputValidatorImpl.validateUserModel(any));
        //assert
        verify(mockInputValidatorImpl.validateUserModel(any));
        verify(mockCreateUserUseCase(any));
      },
    );

    test(
        'should emit [UserError] when ValidateInputs throw exception',
        () async{
          throwExceptionFromValidator();
            //act
            userBloc.add(CreateUserEvent(userModel: tUser));
        },
    );

    test(
      'should emit [UserLoading,UserCreated] when CreateUserUseCase is successful',
          () async{
        //arrange
        when(mockCreateUserUseCase(any)).thenAnswer((_) async => const Right(tInt));
        //assert later
        final expected = [UsersLoading(),const UserCreated(message: USER_CREATED)];
        expectLater(userBloc.stream, emitsInOrder(expected));
        //act
        userBloc.add(CreateUserEvent(userModel: tUser));
      },
    );

    test(
      'should emit [UserLoading,UserError] when CreateUserUseCase is not successful',
          () async{
        //arrange
        when(mockCreateUserUseCase(any)).thenAnswer((_) async => const Left(CacheFailure(message: tMessage)));
        //assert later
        final expected = [UsersLoading(),const UserError(message: tMessage)];
        expectLater(userBloc.stream, emitsInOrder(expected));
        //act
        userBloc.add(CreateUserEvent(userModel: tUser));
      },
    );
  });

  group('EditUserEvent', () {

    test(
      'should call the inputValidator with no exception when all data is valid',
          () async {
        when(mockEditUserUseCase(any)).thenAnswer((realInvocation) async => const Right(MySuccess(message: tMessage)));
        //act
        userBloc.add(EditUserEvent(userModel: tUser));
        await untilCalled(mockInputValidatorImpl.validateUserModel(any));
        //assert
        verify(mockInputValidatorImpl.validateUserModel(any));
        verify(mockEditUserUseCase(any));
      },
    );

    test(
      'should emit [UserError] when ValidateInputs throw exception',
          () async{
        throwExceptionFromValidator();
        //act
        userBloc.add(EditUserEvent(userModel: tUser));
      },
    );

    test(
      'should emit [UserLoading,UserEdited] when EditUserUseCase is successful',
          () async{
        //arrange
        when(mockEditUserUseCase(any)).thenAnswer((_) async => const Right(MySuccess(message: tMessage)));
        //assert later
        final expected = [UsersLoading(),const UserEdited(message: tMessage)];
        expectLater(userBloc.stream, emitsInOrder(expected));
        //act
        userBloc.add(EditUserEvent(userModel: tUser));
      },
    );

    test(
      'should emit [UserLoading,UserError] when EditUserUseCase is not successful',
          () async{
        //arrange
        when(mockEditUserUseCase(any)).thenAnswer((_) async => const Left(CacheFailure(message: tMessage)));
        //assert later
        final expected = [UsersLoading(),const UserError(message: tMessage)];
        expectLater(userBloc.stream, emitsInOrder(expected));
        //act
        userBloc.add(EditUserEvent(userModel: tUser));
      },
    );
  });

  group('DeleteUserEvent', () {

    test(
      'should emit [UserLoading,UserDeleted] when DeleteUserUseCase is successful',
          () async{
        //arrange
        when(mockDeleteUserUseCase(any)).thenAnswer((_) async => const Right(MySuccess(message: tMessage)));
        //assert later
        final expected = [UsersLoading(),const UserDeleted(message: tMessage)];
        expectLater(userBloc.stream, emitsInOrder(expected));
        //act
        userBloc.add(DeleteUserEvent(userModel: tUser));
      },
    );

    test(
      'should emit [UserLoading,UserError] when DeleteUserUseCase is not successful',
          () async{
        //arrange
        when(mockDeleteUserUseCase(any)).thenAnswer((_) async => const Left(CacheFailure(message: tMessage)));
        //assert later
        final expected = [UsersLoading(),const UserError(message: tMessage)];
        expectLater(userBloc.stream, emitsInOrder(expected));
        //act
        userBloc.add(DeleteUserEvent(userModel: tUser));
      },
    );
  });

  group('GetUsersEvent', () {

    test(
      'should emit [UserLoading,UserLoaded] when GetUsersUseCase is successful',
          () async{
        //arrange
        when(mockGetUsersUseCase(any)).thenAnswer((_) async => Right([tUser]));
        //assert later
        final expected = [UsersLoading(), UsersLoaded(users: [tUser])];
        expectLater(userBloc.stream, emitsInOrder(expected));
        //act
        userBloc.add(GetUsersEvent());
      },
    );

    test(
      'should emit [UserLoading,UserError] when GetUsersUseCase is not successful',
          () async{
        //arrange
        when(mockGetUsersUseCase(any)).thenAnswer((_) async => const Left(CacheFailure(message: tMessage)));
        //assert later
        final expected = [UsersLoading(),const UserError(message: tMessage)];
        expectLater(userBloc.stream, emitsInOrder(expected));
        //act
        userBloc.add(GetUsersEvent());
      },
    );
  });
}

