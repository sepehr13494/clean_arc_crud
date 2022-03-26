import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_crud_test/core/util/date_manager.dart';
import 'package:mc_crud_test/features/crud/presentation/bloc/user_bloc.dart';

import '../../data/models/user_model.dart';

class AddEditUser extends StatefulWidget {
  final bool isEdit;
  final UserModel? userModel;

  const AddEditUser({Key? key, this.isEdit = false, this.userModel})
      : super(key: key);

  @override
  State<AddEditUser> createState() => _AddEditUserState();
}

class _AddEditUserState extends State<AddEditUser> {

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bankAccountNumberController = TextEditingController();
  CountryCode countryCode = CountryCode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Edit User" : "Create New User"),),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildTextField("Firstname", firstnameController),
          _buildTextField("Lastname", lastnameController),
          _buildTextField(
              "DateOfBirth", dateOfBirthController, readOnly: true, onTap: () {
            _showDatePicker();
          }),
          _buildTextField("PhoneNumber", phoneNumberController,
              keyBoardType: TextInputType.phone, prefixIcon:CountryCodePicker(
              onChanged: (val){
                setState(() {
                  countryCode = val;
                });
              },
              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              initialSelection: 'IR',
              favorite: const ['+98','IR'],
              // optional. Shows only country name and flag
              showCountryOnly: false,
              // optional. Shows only country name and flag when popup is closed.
              showOnlyCountryWhenClosed: false,
              // optional. aligns the flag and the Text left
              alignLeft: false,
            ),),
          _buildTextField("Email", emailController,
              keyBoardType: TextInputType.emailAddress),
          _buildTextField("BankAccountNumber", bankAccountNumberController),
          const SizedBox(height: 36),
          ElevatedButton(
            onPressed: () {
              _createOrEditUser();
            },
            child: Text(widget.isEdit ? "Confirm Edit" : "Create User"),
          )

        ],
      ),
    );
  }

  Widget _buildTextField(String title, TextEditingController controller,
      {bool readOnly = false,
        Function? onTap,
        TextInputType keyBoardType = TextInputType.text,
        Widget? prefixIcon
      }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textInputAction: TextInputAction.next,
        readOnly: readOnly,
        keyboardType: keyBoardType,
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: title,
        ),
      ),
    );
  }

  _showDatePicker() {
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.parse("1900-01-01"),
        lastDate: DateTime.now()).then((value) {
      if (value != null) {
        dateOfBirthController.text = DateManager.convertDateToString(value);
      }
    });
  }

  void _createOrEditUser() {
    BlocProvider.of<UserBloc>(context,listen: false).add(
        CreateUserEvent(userModel: UserModel.fromJson({
          "Firstname": firstnameController.text,
          "Lastname": lastnameController.text,
          "PhoneNumber": countryCode.dialCode??"" + phoneNumberController.text,
          "Email": emailController.text,
          "BankAccountNumber": bankAccountNumberController.text,
          "isoCode": countryCode.code,
          "DateOfBirth": dateOfBirthController.text,
        })));
  }

}

