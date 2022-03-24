import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/core/error_and_success/succeses.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/create_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/edit_user.dart';

import 'package:mockito/mockito.dart';

import '../repositories/user_repository_test.mocks.dart';





void main() {
  late EditUser useCase;
  late MockUserRepository mockUserRepository;
  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = EditUser(mockUserRepository);
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
  const tSuccess = MySuccess(message: "test success");

  test(
    'should pass the user to the user repository and get edited user from there',
        () async {
      //arrange
      when(mockUserRepository.editUser(any)).thenAnswer((realInvocation) async => const Right(tSuccess));
      //act
      final result = await useCase(Params(userEntity: tUser));
      //assert
      verify(mockUserRepository.editUser(tUser));
      verifyNoMoreInteractions(mockUserRepository);
      expect(result, const Right(tSuccess));
        },
  );
}
