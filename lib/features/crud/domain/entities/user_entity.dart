// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);


import 'package:equatable/equatable.dart';

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

  final int id;
  final String firstname;
  final String lastname;
  final DateTime dateOfBirth;
  final String phoneNumber;
  final String email;
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
