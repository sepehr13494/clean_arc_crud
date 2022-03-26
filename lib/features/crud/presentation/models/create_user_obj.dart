import 'dart:convert';

import 'package:mc_crud_test/core/util/date_manager.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';

class CreateUserObj{
  int? id;
  String? firstname;
  String? lastname;
  String? dateOfBirth;
  String? phoneNumber;
  String? email;
  String? isoCode;
  String? bankAccountNumber;

  CreateUserObj({
    this.id,
    this.firstname,
    this.lastname,
    this.dateOfBirth,
    this.phoneNumber,
    this.email,
    this.isoCode,
    this.bankAccountNumber,
  });

  factory CreateUserObj.fromEntity(UserEntity userEntity) => CreateUserObj(
        id: userEntity.id,
        firstname: userEntity.firstname,
        lastname: userEntity.lastname,
        dateOfBirth: DateManager.convertDateToString(userEntity.dateOfBirth),
        phoneNumber: userEntity.phoneNumber,
        email: userEntity.email,
        bankAccountNumber: userEntity.bankAccountNumber,
        isoCode: userEntity.isoCode,
      );

  factory CreateUserObj.fromJson(Map<String, dynamic> json) => CreateUserObj(
        id: json["id"],
        firstname: json["Firstname"],
        lastname: json["Lastname"],
        dateOfBirth: json["DateOfBirth"],
        phoneNumber: json["PhoneNumber"],
        email: json["Email"],
        bankAccountNumber: json["BankAccountNumber"],
        isoCode: json["isoCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Firstname": firstname,
        "Lastname": lastname,
        "DateOfBirth": dateOfBirth,
        "PhoneNumber": phoneNumber,
        "Email": email,
        "BankAccountNumber": bankAccountNumber,
        "isoCode": isoCode,
      };

  static final CreateUserObj createUserObjForTest = CreateUserObj(
    id: 1,
    firstname: "firstname",
    lastname: "lastname",
    dateOfBirth: "2022-10-12",
    phoneNumber: "09373555973",
    email: "test@gmail.com",
    bankAccountNumber: "12356421356541",
    isoCode: "IR",
  );
}
