// Mocks generated by Mockito 5.1.0 from annotations
// in mc_crud_test/test/features/crud/domain/repositories/user_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mc_crud_test/core/error_and_success/failures.dart' as _i5;
import 'package:mc_crud_test/core/error_and_success/succeses.dart' as _i7;
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart'
    as _i6;
import 'package:mc_crud_test/features/crud/domain/repositories/user_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i3.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.UserEntity>> createUser(
          _i6.UserEntity? user) =>
      (super.noSuchMethod(Invocation.method(#createUser, [user]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.UserEntity>>.value(
              _FakeEither_0<_i5.Failure, _i6.UserEntity>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.UserEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.UserEntity>>> getUsers() =>
      (super.noSuchMethod(Invocation.method(#getUsers, []),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i6.UserEntity>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.UserEntity>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.UserEntity>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.UserEntity>> editUser(
          _i6.UserEntity? user) =>
      (super.noSuchMethod(Invocation.method(#editUser, [user]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.UserEntity>>.value(
              _FakeEither_0<_i5.Failure, _i6.UserEntity>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.UserEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.Success>> deleteUser(
          _i6.UserEntity? user) =>
      (super.noSuchMethod(Invocation.method(#deleteUser, [user]),
              returnValue: Future<_i2.Either<_i5.Failure, _i7.Success>>.value(
                  _FakeEither_0<_i5.Failure, _i7.Success>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i7.Success>>);
}
