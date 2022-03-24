import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tUserModel = UserModel(
    id: 1,
    firstname: "firstname",
    lastname: "lastname",
    dateOfBirth: DateTime.parse("2022-10-12"),
    phoneNumber: "08132168546",
    email: "email@gmail.com",
    bankAccountNumber: "21654321654321",
  );

  test(
    'should be a subclass of userEntity entity',
    () async {
      //assert
      expect(tUserModel, isA<UserEntity>());
    },
  );
  
  group('from json', (){
    test(
        'should return a valid model',
        () async{
            //arrange
            final Map<String, dynamic> jsonMap = json.decode(fixture("user_model.json"));
            //act
            final result = UserModel.fromJson(jsonMap);
            //assert
            expect(result, tUserModel);
        },
    );
  });

  group('to json', (){
    test(
        'should return a json map containing proper data',
        () async{
            //act
          final result = tUserModel.toJson();
            //assert
          final expectedMap = {
            "id": 1,
            "Firstname": "firstname",
            "Lastname": "lastname",
            "DateOfBirth": "2022-10-12",
            "PhoneNumber": "08132168546",
            "Email": "email@gmail.com",
            "BankAccountNumber": "21654321654321"
          };
          expect(result, expectedMap);

        },
    );
  });
}
