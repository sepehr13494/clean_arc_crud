import 'package:dartz/dartz.dart';
import 'package:mc_crud_test/core/error_and_success/exeptions.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';
import 'package:mc_crud_test/core/error_and_success/succeses.dart';
import 'package:mc_crud_test/features/crud/data/data_sources/user_local_data_source.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';
import 'package:mc_crud_test/features/crud/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository{

  final UserLocalDataSource userLocalDataSource;

  UserRepositoryImpl({required this.userLocalDataSource});

  @override
  Future<Either<Failure, UserEntity>> createUser(UserEntity user) async {
    return _repoFunction<UserEntity>(() {
      return userLocalDataSource.createUser(user);
    });
  }

  @override
  Future<Either<Failure, Success>> deleteUser(UserEntity user) async {
    return _repoFunction<Success>(() {
      return userLocalDataSource.deleteUser(user);
    });
  }

  @override
  Future<Either<Failure, UserEntity>> editUser(UserEntity user) async {
    return _repoFunction<UserEntity>(() {
      return userLocalDataSource.editUser(user);
    });
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    return _repoFunction<List<UserEntity>>(() {
      return userLocalDataSource.getUsers();
    });
  }


  Future<Either<Failure,Type>> _repoFunction<Type>(Future<Type> Function() function) async{
    Either<Failure,Type> response;
    try{
      response = Right(await function());
    } on CacheException catch (error){
      response = Left(CacheFailure(message: error.message));
    }
    return response;
  }
}