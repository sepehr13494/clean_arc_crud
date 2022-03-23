import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/core/usecases/usercase.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/domain/repositories/user_repository.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/get_users.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositories/user_repository_test.mocks.dart';




void main() {
  late GetUsers useCase;
  late MockUserRepository mockUserRepository;
  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = GetUsers(mockUserRepository);
  });

  final tUserList = [UserEntity(
    id: 1,
    firstname: "firstname",
    lastname: "lastname",
    dateOfBirth: DateTime.now(),
    phoneNumber: "09373555973",
    email: "test@gmail.com",
    bankAccountNumber: "12356421356541",
  )];

  test(
    'should get all users from user repository',
        () async {
      //arrange
      when(mockUserRepository.getUsers()).thenAnswer((realInvocation) async => Right(tUserList));
      //act
      final result = await useCase(NoParams());
      //assert
      expect(result, Right(tUserList));
      verify(mockUserRepository.getUsers());
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
