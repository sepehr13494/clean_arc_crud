import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';
import 'package:mc_crud_test/core/usecases/usercase.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/domain/repositories/user_repository.dart';

import '../../../../core/error_and_success/succeses.dart';

class CreateUser implements UseCase<int, Params>{
  final UserRepository repository;

  CreateUser(this.repository);

  @override
  Future<Either<Failure, int>?> call(Params params) async {
    return await repository.createUser(params.userEntity);
  }


}

class Params extends Equatable{
  final UserEntity userEntity;

  const Params({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}