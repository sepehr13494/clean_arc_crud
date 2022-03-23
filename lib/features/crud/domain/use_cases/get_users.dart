import 'package:dartz/dartz.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';
import 'package:mc_crud_test/core/usecases/usercase.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';

import '../repositories/user_repository.dart';

class GetUsers implements UseCase<List<UserEntity>,NoParams>{

  final UserRepository repository;

  GetUsers(this.repository);

  @override
  Future<Either<Failure, List<UserEntity>>?> call(NoParams params) async{
    return await repository.getUsers();
  }


}