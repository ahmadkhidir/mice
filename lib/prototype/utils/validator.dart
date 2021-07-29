class Validator {
  static String? validateEmail({required String? email}) {
    RegExp pattern = RegExp(
        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|'(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*')@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])");
    if (email!.isEmpty) {
      return 'Email can\'t be empty';
    }
    if (!pattern.hasMatch(email)) {
      return 'Enter a correct email';
    }
    return null;
  }

  static String? validateName({required String? name}) {
    RegExp pattern1 = RegExp(r"(^[A-Z][a-z]*) [A-Z][a-z]*$");
    RegExp pattern2 = RegExp(r"(^[a-z]*) [a-z]*$");
    RegExp pattern3 = RegExp(r"(^[a-zA-Z]*)$");
    if (name!.isEmpty) {
      return 'Name can\'t be empty';
    }
    if (pattern3.hasMatch(name)) {
      return 'Name must be FirstName and Lastname';
    }
    if (pattern2.hasMatch(name)) {
      return 'Firstname and Lastname must be capitalize';
    }
    if (!pattern1.hasMatch(name)) {
      return 'Full name must be capitalize';
    }
    return null;
  }

  static String? validatePhoneNumber({required String? phoneNumber}) {
    RegExp pattern1 = RegExp(r"^234");
    RegExp pattern2 = RegExp(r"^\+");
    RegExp pattern3 = RegExp(r"[0-9]{11}");
    if (phoneNumber!.isEmpty) {
      return 'Phone number can\'t be empty';
    }
    if (pattern1.hasMatch(phoneNumber)) {
      return "Phone number mustn't include country code";
    }
    if (pattern2.hasMatch(phoneNumber)) {
      return "Phone number mustn't include + sign";
    }
    if (!pattern3.hasMatch(phoneNumber)) {
      return "Phone number must be 11";
    }
    return null;
  }

  static String? validatePassword({required String? password}) {
    RegExp pattern1 = RegExp("^(?=.*[a-z])");
    RegExp pattern2 = RegExp("(?=.*[A-Z])");
    RegExp pattern3 = RegExp("(?=.*[0-9])");
    RegExp pattern4 = RegExp(r"(?=.*[!@#$%^&*.])");
    RegExp pattern5 = RegExp("(?=.{8,})");
    if (password!.isEmpty) {
      return 'Password can\'t be empty';
    }
    if (!pattern1.hasMatch(password)) {
      return "Must contain atleast 1 lowercase";
    }
    if (!pattern2.hasMatch(password)) {
      return "Must contain atleast 1 uppercase";
    }
    if (!pattern3.hasMatch(password)) {
      return "Must contain atleast 1 numeric character";
    }
    if (!pattern4.hasMatch(password)) {
      return "Must contain atleast 1 special character";
    }
    if (!pattern5.hasMatch(password)) {
      return "Must be eight characters or longer";
    }
    return null;
  }
}
