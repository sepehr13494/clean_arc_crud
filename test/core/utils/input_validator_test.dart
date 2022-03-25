import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/core/util/input_validator.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'input_validator_test.mocks.dart';

@GenerateMocks([EmailManager])
@GenerateMocks([PhoneNumberManager])
void main() {
  late InputValidatorImpl inputValidator;
  late MockEmailManager mockEmailManager;
  late MockPhoneNumberManager mockPhoneNumberManager;

  setUp(() {
    mockEmailManager = MockEmailManager();
    mockPhoneNumberManager = MockPhoneNumberManager();
    inputValidator = InputValidatorImpl(emailManager: mockEmailManager,
        phoneNumberManager: mockPhoneNumberManager);
  });

  group('validatePhoneNumber', () {
    const tNumber = "09325132165";
    const tCode = "IR";
    test(
      'should return true when phone is valid',
          () async {
        //arrange
        when(mockPhoneNumberManager.checkValidation(isoCode: anyNamed("isoCode"),phoneNumber: anyNamed("phoneNumber"))).thenAnswer((realInvocation) async => true);
        //act
        final result = await inputValidator.validatePhoneNumber(isoCode: tCode, phoneNumber: tNumber);
        //assert
        verify(mockPhoneNumberManager.checkValidation(phoneNumber: tNumber,isoCode: tCode));
        expect(result, true);
      },
    );

    test(
      'should return false when phone is not valid',
          () async {
        //arrange
        when(mockPhoneNumberManager.checkValidation(isoCode: anyNamed("isoCode"),phoneNumber: anyNamed("phoneNumber"))).thenAnswer((realInvocation) async => false);
        //act
        final result = await inputValidator.validatePhoneNumber(isoCode: tCode, phoneNumber: tNumber);
        //assert
        verify(mockPhoneNumberManager.checkValidation(phoneNumber: tNumber,isoCode: tCode));
        expect(result, false);
      },
    );

  });

  group('validateEmail', () {
    const tEmail = "email";
    test(
      'should return true when email is valid',
          () async {
        //arrange
        when(mockEmailManager.checkValidation(email: anyNamed("email"))).thenAnswer((realInvocation) async => true);
        //act
        final result = await inputValidator.validateEmail(email: tEmail);
        //assert
        verify(mockEmailManager.checkValidation(email: tEmail));
        expect(result, true);
      },
    );

    test(
      'should return false when email is not valid',
          () async {
        //arrange
        when(mockEmailManager.checkValidation(email: anyNamed("email"))).thenAnswer((realInvocation) async => false);
        //act
        final result = await inputValidator.validateEmail(email: tEmail);
        //assert
        verify(mockEmailManager.checkValidation(email: tEmail));
        expect(result, false);
      },
    );
  });

  group('validateBankAccount', () {
    const tBankAccount = "tBankAccount";

    test(
      'should return true always',
          () async {
        //act
        final result = await inputValidator.validateBankAccount(bankAccount: tBankAccount);
        //assert
        expect(result, true);
      },
    );
  });
}