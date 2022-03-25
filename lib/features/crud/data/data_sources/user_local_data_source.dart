import 'dart:async';

import 'package:hive/hive.dart';
import 'package:mc_crud_test/core/error_and_success/exeptions.dart';

import '../../../../core/error_and_success/succeses.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource{
  Future<int>? createUser(UserModel user);
  Future<Success>? deleteUser(UserModel user);
  Future<Success>? editUser(UserModel user);
  Future<List<UserModel>>? getUsers();
}

class UserLocalDataSourceImpl implements UserLocalDataSource{
  final Box box;

  UserLocalDataSourceImpl({required this.box});

  @override
  Future<int>? createUser(UserEntity user) async {
    try{
      int id = await box.add(user);
      return id;
    } catch (e){
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<Success>? deleteUser(UserEntity user) async {
    try{
      await box.delete(user.id);
      return const MySuccess(message: "deleted");
    } catch (e){
      throw CacheException(message: "from me : " + e.toString());
    }
  }

  @override
  Future<Success>? editUser(UserEntity user) async {
    try{
      await box.put(user.id,user);
      return const MySuccess(message: "edited");
    } catch (e){
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<List<UserModel>>? getUsers() async {
    try{
      List list = box.toMap().values.toList();
      List<UserModel> userModels = [];
      for (var element in list) {
        userModels.add(element);
      }
      return userModels;
    } catch (e){
      throw CacheException(message: e.toString());
    }
  }

}