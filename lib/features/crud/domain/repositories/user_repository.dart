import 'package:dartz/dartz.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';
import 'package:mc_crud_test/core/error_and_success/succeses.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';

abstract class UserRepository{
  Future<Either<Failure,int>> createUser(UserEntity user);
  Future<Either<Failure,List<UserEntity>>> getUsers();
  Future<Either<Failure,Success>> editUser(UserEntity user);
  Future<Either<Failure,Success>> deleteUser(UserEntity user);
}