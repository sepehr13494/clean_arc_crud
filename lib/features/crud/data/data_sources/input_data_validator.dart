import 'package:hive/hive.dart';
import 'package:mc_crud_test/core/error_and_success/exeptions.dart';
import 'package:mc_crud_test/features/crud/data/models/user_model.dart';

abstract class InputDataValidator{
  Future<void> checkForExistingData(UserModel userModel, {bool isEdit = false});
}

class InputDataValidatorImpl implements InputDataValidator{

  final Box box;

  const InputDataValidatorImpl({required this.box});

  @override
  Future<void> checkForExistingData(UserModel userModel, {bool isEdit = false}) async{
    Map<dynamic,dynamic> map = box.toMap();
    map.forEach((key, value) {
      if(!isEdit || key != userModel.id){
        var element = value;
        if((element as UserModel).firstname == userModel.firstname){
          throw CacheException(message: "first name already exists");
        }
        if((element).dateOfBirth == userModel.dateOfBirth){
          throw CacheException(message: "date of birthday already exists");
        }
        if((element).lastname == userModel.lastname){
          throw CacheException(message: "last name already exists");
        }
        if((element).email == userModel.email){
          throw CacheException(message: "email already exists");
        }
      }
    });

    return;
  }

}