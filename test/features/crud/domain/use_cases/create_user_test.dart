import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/create_user.dart';

import 'package:mockito/mockito.dart';

import '../repositories/user_repository_test.mocks.dart';





void main() {
  late CreateUserUseCase useCase;
  late MockUserRepository mockUserRepository;
  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = CreateUserUseCase(mockUserRepository);
  });

  final tUser = UserModel.userModelForTest;
  const int tId = 1;

  test(
    'should pass the user to the user repository and get created user from there',
    () async {
      //arrange
      when(mockUserRepository.createUser(any)).thenAnswer((realInvocation) async => const Right(tId));
      //act
      final result = await useCase(Params(userEntity: tUser));
      //assert
      verify(mockUserRepository.createUser(tUser));
      expect(result, const Right(tId));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
