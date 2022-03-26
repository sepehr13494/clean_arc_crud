import 'dart:async';

import 'package:hive/hive.dart';
import 'package:mc_crud_test/core/error_and_success/exeptions.dart';

import '../../../../core/error_and_success/succeses.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

const String USER_EDITED = "user edited";
const String USER_DELETED = "user deleted";
const String USER_CREATED = "User Created SuccessFully!";

abstract class UserLocalDataSource {
  Future<int>? createUser(UserModel user);

  Future<Success>? deleteUser(UserModel user);

  Future<Success>? editUser(UserModel user);

  Future<List<UserModel>>? getUsers();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box box;

  UserLocalDataSourceImpl({required this.box});

  @override
  Future<int>? createUser(UserEntity user) async {
    try {
      int id = await box.add(user);
      return id;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<Success>? deleteUser(UserEntity user) async {
    try {
      await box.delete(user.id);
      return const MySuccess(message: USER_DELETED);
    } catch (e) {
      throw CacheException(message: "from me : " + e.toString());
    }
  }

  @override
  Future<Success>? editUser(UserEntity user) async {
    try {
      print(user.id);
      await box.put(user.id, user);
      return const MySuccess(message: USER_EDITED);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<List<UserModel>>? getUsers() async {
    try {
      List list = box.toMap().values.toList();
      List<UserModel> userModels = [];
      for (int i = 0; i < list.length; i++) {
        userModels.add(UserModel(
          id: box.toMap().keys.toList()[i],
          firstname: list[i].firstname,
          lastname: list[i].lastname,
          dateOfBirth: list[i].dateOfBirth,
          phoneNumber: list[i].phoneNumber,
          email: list[i].email,
          isoCode: list[i].isoCode,
          bankAccountNumber: list[i].bankAccountNumber,
        ));
      }
      return userModels;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
