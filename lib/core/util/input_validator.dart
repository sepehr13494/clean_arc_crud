import 'package:email_validator/email_validator.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:mc_crud_test/core/error_and_success/exeptions.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';
import 'package:mc_crud_test/features/crud/domain/entities/user_entity.dart';

abstract class InputValidator{
  Future<bool> validatePhoneNumber({required String phoneNumber,required String isoCode});
  Future<bool> validateEmail({required String email});
  Future<bool> validateBankAccount({required String bankAccount});
  Future<void> validateUserModel(UserModel userModel);
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

  @override
  Future<bool> validateBankAccount({required String bankAccount}) async{
    return true;
  }

  @override
  Future<void> validateUserModel(UserModel userModel) async{
    Map<String, dynamic> json = userModel.toJson();
    json.forEach((key, value) {
      if(key != "id"){
        if(value == null || value.toString().trim().isEmpty){
          throw InputValidationException(message: "Please fill all fields");
        }
      }
    });
    bool phoneValid = await validatePhoneNumber(phoneNumber: userModel.phoneNumber, isoCode: userModel.isoCode);
    if(!phoneValid){
      throw InputValidationException(message: "Invalid Phone Number");
    }
    bool emailValid = await validateEmail(email: userModel.email);
    if(emailValid){
      throw InputValidationException(message: "Invalid email");
    }

    bool bankAccountValid = await validateBankAccount(bankAccount: userModel.bankAccountNumber);
    if(bankAccountValid){
      throw InputValidationException(message: "Invalid bank account");
    }
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