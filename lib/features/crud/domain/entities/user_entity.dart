// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.bankAccountNumber,
  });

  @HiveField(0)
  final int id;
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

  @override
  List<Object?> get props => [
    id,
    firstname,
    lastname,
    dateOfBirth,
    phoneNumber,
    email,
    bankAccountNumber,
  ];

}
