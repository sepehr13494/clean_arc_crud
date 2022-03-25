import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/core/error_and_success/succeses.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/create_user.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/delete_user.dart';

import 'package:mockito/mockito.dart';

import '../repositories/user_repository_test.mocks.dart';





void main() {
  late DeleteUserUseCase useCase;
  late MockUserRepository mockUserRepository;
  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = DeleteUserUseCase(mockUserRepository);
  });

  Success tSuccess = const MySuccess(message: 'success');

  final tUser = UserModel.userModelForTest;

  test(
    'should pass the user to the user repository and get success from there',
        () async {
      //arrange
      when(mockUserRepository.deleteUser(any)).thenAnswer((realInvocation) async => Right(tSuccess));
      //act
      final result = await useCase(Params(userEntity: tUser));
      //assert
      expect(result, Right(tSuccess));
      verify(mockUserRepository.deleteUser(tUser));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
