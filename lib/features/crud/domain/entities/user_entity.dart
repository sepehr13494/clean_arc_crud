// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

UserEntity userEntityFromJson(String str) => UserEntity.fromJson(json.decode(str));

String userEntityToJson(UserEntity data) => json.encode(data.toJson());

class UserEntity extends Equatable{
  const UserEntity({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.bankAccountNumber,
  });

  final int id;
  final String firstname;
  final String lastname;
  final DateTime dateOfBirth;
  final String phoneNumber;
  final String email;
  final String bankAccountNumber;

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    id: json["id"],
    firstname: json["Firstname"],
    lastname: json["Lastname"],
    dateOfBirth: DateTime.parse(json["DateOfBirth"]),
    phoneNumber: json["PhoneNumber"],
    email: json["Email"],
    bankAccountNumber: json["BankAccountNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Firstname": firstname,
    "Lastname": lastname,
    "DateOfBirth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "PhoneNumber": phoneNumber,
    "Email": email,
    "BankAccountNumber": bankAccountNumber,
  };

  @override
  List<Object?> get props => [id];
}
