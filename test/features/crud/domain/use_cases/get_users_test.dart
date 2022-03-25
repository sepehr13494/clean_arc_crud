import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/core/usecases/usercase.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/get_users.dart';
import 'package:mockito/mockito.dart';

import '../repositories/user_repository_test.mocks.dart';




void main() {
  late GetUsersUseCase useCase;
  late MockUserRepository mockUserRepository;
  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = GetUsersUseCase(mockUserRepository);
  });

  final tUserList = [UserModel.userModelForTest];

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
