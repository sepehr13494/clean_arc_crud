import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tUserModel = UserModel.userModelForTest;

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
          final expectedMap = json.decode(fixture("user_model.json"));
          expect(result, expectedMap);

        },
    );
  });
}
