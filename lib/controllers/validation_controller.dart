import 'package:get/get.dart';

class ValidationController extends GetxController {
  String? validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      return 'Invalid Email';
    }
  }

  String? validatePassword(String password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(password)) {
      return 'password must have letters, special character and numbers';
    }
  }

  String? validateName(String name) {
    RegExp regExp = RegExp(r"^[\p{L} ,.'-]*$",
        caseSensitive: false, unicode: true, dotAll: true);
    if (name.length > 0) {
      if (!regExp.hasMatch(name)) {
        return 'name can have letters only';
      }
    } else {
      return 'Name should have more than 3 characters';
    }
  }

  String? validateMobile(String value) {
    String patttern =
        r'(^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
  }
}
