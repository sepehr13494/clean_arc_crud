import 'package:dartz/dartz.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';
import 'package:mc_crud_test/core/usecases/usercase.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/domain/repositories/user_repository.dart';
import 'package:mc_crud_test/features/crud/domain/use_cases/create_user.dart';

import '../../../../core/error_and_success/succeses.dart';

class EditUser implements UseCase<Success, Params>{
  final UserRepository repository;

  EditUser(this.repository);

  @override
  Future<Either<Failure, Success>?> call(Params params) async {
    return await repository.editUser(params.userEntity);
  }

}