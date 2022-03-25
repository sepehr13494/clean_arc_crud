// Mocks generated by Mockito 5.1.0 from annotations
// in mc_crud_test/test/features/crud/presentation/bloc/user_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i6;
import 'package:mc_crud_test/core/error_and_success/failures.dart' as _i7;
import 'package:mc_crud_test/core/error_and_success/succeses.dart' as _i9;
import 'package:mc_crud_test/core/usecases/usercase.dart' as _i13;
import 'package:mc_crud_test/core/util/input_validator.dart' as _i3;
import 'package:mc_crud_test/features/crud/data/models/user_model.dart' as _i14;
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart'
    as _i12;
import 'package:mc_crud_test/features/crud/domain/repositories/user_repository.dart'
    as _i2;
import 'package:mc_crud_test/features/crud/domain/use_cases/create_user.dart'
    as _i4;
import 'package:mc_crud_test/features/crud/domain/use_cases/delete_user.dart'
    as _i10;
import 'package:mc_crud_test/features/crud/domain/use_cases/edit_user.dart'
    as _i8;
import 'package:mc_crud_test/features/crud/domain/use_cases/get_users.dart'
    as _i11;
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

class _FakeUserRepository_0 extends _i1.Fake implements _i2.UserRepository {}

class _FakePhoneNumberManager_1 extends _i1.Fake
    implements _i3.PhoneNumberManager {}

class _FakeEmailManager_2 extends _i1.Fake implements _i3.EmailManager {}

/// A class which mocks [CreateUserUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreateUserUseCase extends _i1.Mock implements _i4.CreateUserUseCase {
  MockCreateUserUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeUserRepository_0()) as _i2.UserRepository);
  @override
  _i5.Future<_i6.Either<_i7.Failure, int>?> call(_i4.Params? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<_i6.Either<_i7.Failure, int>?>.value())
          as _i5.Future<_i6.Either<_i7.Failure, int>?>);
}

/// A class which mocks [EditUserUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockEditUserUseCase extends _i1.Mock implements _i8.EditUserUseCase {
  MockEditUserUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeUserRepository_0()) as _i2.UserRepository);
  @override
  _i5.Future<_i6.Either<_i7.Failure, _i9.Success>?> call(_i4.Params? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue:
                  Future<_i6.Either<_i7.Failure, _i9.Success>?>.value())
          as _i5.Future<_i6.Either<_i7.Failure, _i9.Success>?>);
}

/// A class which mocks [DeleteUserUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteUserUseCase extends _i1.Mock implements _i10.DeleteUserUseCase {
  MockDeleteUserUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeUserRepository_0()) as _i2.UserRepository);
  @override
  _i5.Future<_i6.Either<_i7.Failure, _i9.Success>?> call(_i4.Params? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue:
                  Future<_i6.Either<_i7.Failure, _i9.Success>?>.value())
          as _i5.Future<_i6.Either<_i7.Failure, _i9.Success>?>);
}

/// A class which mocks [GetUsersUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUsersUseCase extends _i1.Mock implements _i11.GetUsersUseCase {
  MockGetUsersUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeUserRepository_0()) as _i2.UserRepository);
  @override
  _i5.Future<_i6.Either<_i7.Failure, List<_i12.UserEntity>>?> call(
          _i13.NoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<
                  _i6.Either<_i7.Failure, List<_i12.UserEntity>>?>.value())
          as _i5.Future<_i6.Either<_i7.Failure, List<_i12.UserEntity>>?>);
}

/// A class which mocks [InputValidatorImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockInputValidatorImpl extends _i1.Mock
    implements _i3.InputValidatorImpl {
  MockInputValidatorImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.PhoneNumberManager get phoneNumberManager =>
      (super.noSuchMethod(Invocation.getter(#phoneNumberManager),
          returnValue: _FakePhoneNumberManager_1()) as _i3.PhoneNumberManager);
  @override
  _i3.EmailManager get emailManager =>
      (super.noSuchMethod(Invocation.getter(#emailManager),
          returnValue: _FakeEmailManager_2()) as _i3.EmailManager);
  @override
  _i5.Future<bool> validatePhoneNumber(
          {String? phoneNumber, String? isoCode}) =>
      (super.noSuchMethod(
          Invocation.method(#validatePhoneNumber, [],
              {#phoneNumber: phoneNumber, #isoCode: isoCode}),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<bool> validateEmail({String? email}) => (super.noSuchMethod(
      Invocation.method(#validateEmail, [], {#email: email}),
      returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<bool> validateBankAccount({String? bankAccount}) =>
      (super.noSuchMethod(
          Invocation.method(
              #validateBankAccount, [], {#bankAccount: bankAccount}),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<void> validateUserModel(_i14.UserModel? userModel) =>
      (super.noSuchMethod(Invocation.method(#validateUserModel, [userModel]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
}
