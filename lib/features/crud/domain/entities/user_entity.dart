// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:mc_crud_test/features/crud/presentation/models/create_user_obj.dart';


class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.bankAccountNumber,
    required this.isoCode,
  });

  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String firstname;
  @HiveField(2)
  final String lastname;
  @HiveField(3)
  final DateTime dateOfBirth;
  @HiveField(4)
  final String phoneNumber;
  @HiveField(5)
  final String email;
  @HiveField(6)
  final String bankAccountNumber;
  @HiveField(7)
  final String isoCode;

  factory UserEntity.fromCreateUserObj(CreateUserObj createUserObj) => UserEntity(
    id: createUserObj.id,
    firstname: createUserObj.firstname!,
    lastname: createUserObj.lastname!,
    dateOfBirth: DateTime.parse(createUserObj.dateOfBirth!),
    phoneNumber: createUserObj.phoneNumber!,
    email: createUserObj.email!,
    bankAccountNumber: createUserObj.bankAccountNumber!,
    isoCode: createUserObj.isoCode!,
  );

  @override
  List<Object?> get props => [
    id,
    firstname,
    lastname,
    dateOfBirth,
    phoneNumber,
    email,
    bankAccountNumber,
    isoCode
  ];



}
