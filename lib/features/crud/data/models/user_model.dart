import 'dart:convert';

import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends UserEntity {

  const UserModel(
      {int? id,
      required String firstname,
      required String lastname,
      required DateTime dateOfBirth,
      required String phoneNumber,
      required String email,
      required String isoCode,
      required String bankAccountNumber})
      : super(
          id: id,
          firstname: firstname,
          lastname: lastname,
          dateOfBirth: dateOfBirth,
          phoneNumber: phoneNumber,
          email: email,
          bankAccountNumber: bankAccountNumber,
    isoCode: isoCode,
        );

  factory UserModel.fromEntity(UserEntity userEntity) => UserModel(
        id: userEntity.id,
        firstname: userEntity.firstname,
        lastname: userEntity.lastname,
        dateOfBirth: userEntity.dateOfBirth,
        phoneNumber: userEntity.phoneNumber,
        email: userEntity.email,
        bankAccountNumber: userEntity.bankAccountNumber,
    isoCode: userEntity.isoCode,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstname: json["Firstname"],
        lastname: json["Lastname"],
        dateOfBirth: DateTime.parse(json["DateOfBirth"]),
        phoneNumber: json["PhoneNumber"],
        email: json["Email"],
        bankAccountNumber: json["BankAccountNumber"],
        isoCode: json["isoCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Firstname": firstname,
        "Lastname": lastname,
        "DateOfBirth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "PhoneNumber": phoneNumber,
        "Email": email,
        "BankAccountNumber": bankAccountNumber,
        "isoCode": isoCode,
      };

  static final UserModel userModelForTest = UserModel(
    id: 1,
    firstname: "firstname",
    lastname: "lastname",
    dateOfBirth: DateTime.parse("2022-10-12"),
    phoneNumber: "09373555973",
    email: "test@gmail.com",
    bankAccountNumber: "12356421356541",
    isoCode: "IR",
  );
}
