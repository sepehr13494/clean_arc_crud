import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/core/error_and_success/exeptions.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';
import 'package:mc_crud_test/core/error_and_success/succeses.dart';
import 'package:mc_crud_test/features/crud/data/data_sources/user_local_data_source.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mc_crud_test/features/crud/data/repositories/user_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([UserLocalDataSource])
void main() {
  late MockUserLocalDataSource mockUserLocalDataSource;
  late UserRepositoryImpl repositoryImpl;
  final tUser = UserModel(
    id: 1,
    firstname: "firstname",
    lastname: "lastname",
    dateOfBirth: DateTime.now(),
    phoneNumber: "09373555973",
    email: "test@gmail.com",
    bankAccountNumber: "12356421356541",
  );
  const tSuccess = MySuccess(message: 'test success');
  String tMessage = "test message";

  setUp(() {
    mockUserLocalDataSource = MockUserLocalDataSource();
    repositoryImpl =
        UserRepositoryImpl(userLocalDataSource: mockUserLocalDataSource);
  });

  group('create user', () {
    const int tId = 1;
    test(
      'should return UserModel when create user is successful',
      () async {
        //arrange
        when(mockUserLocalDataSource.createUser(any)).thenAnswer((realInvocation) async => tId);
        //act
        final result = await repositoryImpl.createUser(tUser);
        //assert
        verify(mockUserLocalDataSource.createUser(tUser));
        expect(result, equals(const Right(tId)));
      },
    );

    test(
      'should return CashFailure when create user is not successful',
          () async {
        //arrange
        when(mockUserLocalDataSource.createUser(any)).thenThrow(CacheException(message: tMessage));
        //act
        final result = await repositoryImpl.createUser(tUser);
        //assert
        verify(mockUserLocalDataSource.createUser(tUser));
        expect(result, equals(Left(CacheFailure(message: tMessage))));
      },
    );
  });

  group('delete user', () {
    test(
      'should return Success when delete user is successful',
          () async {
        //arrange
        when(mockUserLocalDataSource.deleteUser(any)).thenAnswer((realInvocation) async => tSuccess);
        //act
        final result = await repositoryImpl.deleteUser(tUser);
        //assert
        verify(mockUserLocalDataSource.deleteUser(tUser));
        expect(result, equals(const Right(tSuccess)));
      },
    );

    test(
      'should return CashFailure when delete user is not successful',
          () async {
        //arrange
        when(mockUserLocalDataSource.deleteUser(any)).thenThrow(CacheException(message: tMessage));
        //act
        final result = await repositoryImpl.deleteUser(tUser);
        //assert
        verify(mockUserLocalDataSource.deleteUser(tUser));
        expect(result, equals(Left(CacheFailure(message: tMessage))));
      },
    );
  });

  group('edit user', () {
    test(
      'should return UserModel when edit user is successful',
          () async {
        //arrange
        when(mockUserLocalDataSource.editUser(any)).thenAnswer((realInvocation) async => tSuccess);
        //act
        final result = await repositoryImpl.editUser(tUser);
        //assert
        verify(mockUserLocalDataSource.editUser(tUser));
        expect(result, equals(const Right(tSuccess)));
      },
    );

    test(
      'should return CashFailure when edit user is not successful',
          () async {
        //arrange
        when(mockUserLocalDataSource.editUser(any)).thenThrow(CacheException(message: tMessage));
        //act
        final result = await repositoryImpl.editUser(tUser);
        //assert
        verify(mockUserLocalDataSource.editUser(tUser));
        expect(result, equals(Left(CacheFailure(message: tMessage))));
      },
    );
  });

  group('get users', () {
    List<UserModel> tUsersList = [tUser];
    test(
      'should return UserModel list when get users is successful',
          () async {
        //arrange
        when(mockUserLocalDataSource.getUsers()).thenAnswer((realInvocation) async => tUsersList);
        //act
        final result = await repositoryImpl.getUsers();
        //assert
        verify(mockUserLocalDataSource.getUsers());
        expect(result, equals(Right(tUsersList)));
      },
    );

    test(
      'should return CashFailure when get users is not successful',
          () async {
        //arrange
        when(mockUserLocalDataSource.getUsers()).thenThrow(CacheException(message: tMessage));
        //act
        final result = await repositoryImpl.getUsers();
        //assert
        verify(mockUserLocalDataSource.getUsers());
        expect(result, equals(Left(CacheFailure(message: tMessage))));
      },
    );
  });
}
