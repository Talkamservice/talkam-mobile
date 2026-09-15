import 'dart:developer';

import 'package:form_field_validator/form_field_validator.dart';

class ConfirmPasswordValidator extends TextFieldValidator {
  ConfirmPasswordValidator(
      {required String errorText, required this.comparedPassword})
      : super(errorText);


  final String comparedPassword;

  // @override
  // bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {

    log('COMPARED PASSWORD: $comparedPassword');
    log('PASSWORD: $value');
    log((comparedPassword.toString() == value.toString()).toString());
    return comparedPassword.toString() == value.toString();
  }}



class SpaceValidator extends TextFieldValidator {
  SpaceValidator(
      {required String errorText,})
      : super(errorText);




  // @override
  // bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {


    return !(value?.contains(" ")??false);
  }}
class ComplexPasswordValidator extends TextFieldValidator {
  ComplexPasswordValidator() : super("");

  String _dynamicError = "";

  @override
  String get errorText => _dynamicError;

  @override
  bool isValid(String? value) {
    if (value == null || value.isEmpty) return true;
    
    List<String> missing = [];
    if (value.length < 8 || value.length > 32) missing.add("• 8-32 characters");
    if (!value.contains(RegExp(r'[A-Z]'))) missing.add("• 1 uppercase letter");
    if (!value.contains(RegExp(r'[a-z]'))) missing.add("• 1 lowercase letter");
    if (!value.contains(RegExp(r'[0-9]'))) missing.add("• 1 digit");
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>\-_\+=\/\\\[\]~`]'))) missing.add("• 1 special character");
    
    if (missing.isNotEmpty) {
      _dynamicError = "Password must contain:\n" + missing.join("\n");
      return false;
    }
    return true;
  }
}
