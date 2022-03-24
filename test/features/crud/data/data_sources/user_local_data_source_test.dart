import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mc_crud_test/core/error_and_success/exeptions.dart';
import 'package:mc_crud_test/core/error_and_success/succeses.dart';
import 'package:mc_crud_test/features/crud/data/data_sources/user_local_data_source.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_local_data_source_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late UserLocalDataSourceImpl dataSourceImpl;
  late MockBox mockBox;

  final tUser = UserModel.userModelForTest;
  const String tMessage = "test message";
  final tSuccess = MySuccess(message: "test success");

  setUp(() {
    mockBox = MockBox();
    dataSourceImpl = UserLocalDataSourceImpl(box: mockBox);
  });

  group('create user', () {
    const tInt = 1;
    test(
      'should return id when create user with hive is successful',
      () async {
        //arrange
        when(mockBox.add(any)).thenAnswer((realInvocation) async => tInt);
        //act
        final result = await dataSourceImpl.createUser(tUser);
        //assert
        verify(mockBox.add(tUser));
        expect(result, equals(tInt));
      },
    );

    test(
      'should return CacheException when create user with hive is not successful',
      () async {
        //arrange
        when(mockBox.add(any)).thenThrow(CacheException(message: tMessage));
        //act
        final call = dataSourceImpl.createUser;
        //assert
        expect(() => call(tUser), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('edit user', () {
    test(
      'should return success when edit user with hive is successful',
      () async {
        //act
        final result = await dataSourceImpl.editUser(tUser);
        //assert
        verify(mockBox.put(tUser.id, tUser));
        expect(result, isA<MySuccess>());
      },
    );

    test(
      'should return CacheException when edit user with hive is not successful',
      () async {
        //arrange
        when(mockBox.put(any, any))
            .thenThrow(CacheException(message: tMessage));
        //act
        final call = dataSourceImpl.editUser;
        //assert
        expect(() => call(tUser), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('delete user', () {
    test(
      'should return success when delete user with hive is successful',
      () async {
        //act
        final result = await dataSourceImpl.deleteUser(tUser);
        //assert
        verify(mockBox.delete(tUser.id));
        expect(result, isA<MySuccess>());
      },
    );

    test(
      'should return CacheException when create user with hive is not successful',
      () async {
        //arrange
        when(mockBox.delete(any)).thenThrow(CacheException(message: tMessage));
        //act
        final call = dataSourceImpl.deleteUser;
        //assert
        expect(() => call(tUser), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('get users', () {
    final tList = [tUser];
    test(
      'should return UserModel list when get users with hive is successful',
      () async {
        //arrange
        var map = { for (var e in tList) e.id : e };
        when(mockBox.toMap())
            .thenAnswer((realInvocation) => map);
        //act
        final result = await dataSourceImpl.getUsers();
        //assert
        verify(mockBox.toMap());
        expect(result, equals(tList));
      },
    );

    test(
      'should return CacheException when get users with hive is not successful',
      () async {
        //arrange
        when(mockBox.toMap().values.toList())
            .thenThrow(CacheException(message: tMessage));
        //act
        final call = dataSourceImpl.getUsers;
        //assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });
}
