import 'package:email_validator/email_validator.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';

abstract class InputValidator{
  Future<bool> validatePhoneNumber({required String phoneNumber,required String isoCode});
  Future<bool> validateEmail({required String email});
}

class InputValidatorImpl implements InputValidator{

  final PhoneNumberManager phoneNumberManager;
  final EmailManager emailManager;

  InputValidatorImpl({required this.phoneNumberManager, required this.emailManager});

  @override
  Future<bool> validatePhoneNumber({required String phoneNumber,required String isoCode}) async{
    return phoneNumberManager.checkValidation(phoneNumber: phoneNumber, isoCode: isoCode);
  }

  @override
  Future<bool> validateEmail({required String email}) async{
    return emailManager.checkValidation(email: email);
  }
}

class PhoneNumberManager{
  Future<bool> checkValidation({required String phoneNumber,required String isoCode}) async {
    return (await PhoneNumberUtil.isValidPhoneNumber(phoneNumber: phoneNumber, isoCode: isoCode))??false;
  }
}

class EmailManager{
  Future<bool> checkValidation({required String email}) async {
    return EmailValidator.validate(email);
  }
}

class InvalidInputFailure extends Failure{
  const InvalidInputFailure({required String message}) : super(message: message);
}