import 'dart:async';

import '../../../../core/error_and_success/succeses.dart';
import '../../domain/entities/user_entity.dart';

abstract class UserLocalDataSource{
  Future<UserEntity> createUser(UserEntity user);
  Future<Success> deleteUser(UserEntity user);
  Future<UserEntity> editUser(UserEntity user);
  Future<List<UserEntity>> getUsers();
}