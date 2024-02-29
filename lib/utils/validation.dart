import 'package:libphonenumber/libphonenumber.dart';

class Validation {
  static emailValidate(email) {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email);
  }

  static passwordLength(String password) {
    return password.length >= 8;
  }

  // make sure the phone is valid
  static phoneValidate(String phone) async {
    try {
      bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
          phoneNumber: phone, isoCode: 'ID');
      return isValid;
    } catch (e) {
      return false;
    }
  }

  static isNull(params) {
    return params == null || params == '' || params.isEmpty;
  }
}
