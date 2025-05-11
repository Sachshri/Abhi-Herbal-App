class Validators {
  static String? emailValidator(String? email) {
    if (email == null) {
      return "Email Required";
    }
    RegExp regex = RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,}$');
    if (!regex.hasMatch(email)) {
      return "Invalid Email Address!";
    }

    return null;
  }

  static String? phoneNumberValidator(String? phoneNumber) {
    if (phoneNumber == null) {
      return "Phone Number Required";
    }
    RegExp regex = RegExp(r'^\d{10}$');
    if (!regex.hasMatch(phoneNumber)) {
      return "Invalid Phone Number!";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    //min password length

    if (value.length < 4) {
      return "Password must be atleast 4 character long";
    }
    return null;
  }
  static String? validateEmptyText(String fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }
}
