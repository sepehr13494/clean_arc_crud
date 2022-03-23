import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/domain/repositories/user_repository.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/create_user.dart';

import 'package:mockito/mockito.dart';

import '../repositories/user_repository_test.mocks.dart';





void main() {
  late CreateUser useCase;
  late MockUserRepository mockUserRepository;
  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = CreateUser(mockUserRepository);
  });

  final tUser = UserEntity(
    id: 1,
    firstname: "firstname",
    lastname: "lastname",
    dateOfBirth: DateTime.now(),
    phoneNumber: "09373555973",
    email: "test@gmail.com",
    bankAccountNumber: "12356421356541",
  );
  final returnedUser = UserEntity(
    id: 1,
    firstname: "firstname",
    lastname: "lastname",
    dateOfBirth: DateTime.now(),
    phoneNumber: "09373555973",
    email: "test@gmail.com",
    bankAccountNumber: "12356421356541",
  );

  test(
    'should pass the user to the user repository and get created user from there',
    () async {
      //arrange
      when(mockUserRepository.createUser(any)).thenAnswer((realInvocation) async => Right(tUser));
      //act
      final result = await useCase(Params(userEntity: tUser));
      //assert
      expect(result, Right(returnedUser));
      verify(mockUserRepository.createUser(returnedUser));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
