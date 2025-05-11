class CustomFirebaseAuthException implements Exception {
  final String code;
  CustomFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Please use another email.';
      case 'keychain-error':
        return 'A keychain error occurred. Please try again.';
      case 'internal-error':
        return 'An internal error occurred. Please try again.';
      case 'invalid-user-token':
        return 'Your session has expired. Please log in again.';
      case 'captacha-check-failed':
        return 'Captcha check failed. Please try again.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'requires-recent-login':
        return 'Please log in again before performing this action.';
      case 'credential-already-in-use':
        return 'This credential is already linked to another account.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with this email but different sign-in credentials. Try logging in using another method.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new one.';
      case 'invalid-verification-code':
        return 'The verification code is invalid. Please check and try again.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please request a new one.';
      case 'quota-exceeded':
        return 'The SMS quota for this project has been exceeded. Try again later.';
      case 'invalid-credential':
        return 'The provided credential is invalid. Please check and try again.';
      case 'user-token-expired':
      case 'user-token-revoked':
        return 'Your session has expired. Please log in again.';
      default:
        return 'An authentication error occurred. Please try again.';
    }
  }
}

/// Custom exception class to handle various format-related errors.
class CustomFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const CustomFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);

  /// Create a format exception from a specific error message.
  factory CustomFormatException.fromMessage(String message) {
    return CustomFormatException(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory CustomFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const CustomFormatException('The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const CustomFormatException('The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const CustomFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const CustomFormatException('The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const CustomFormatException('The credit card format is invalid. Please enter a valid credit card number.');
      default:
        return const CustomFormatException();
    }
  }

  @override
  String toString() => 'CustomFormatException: $message';
}


class CustomPlatformException implements Exception {
  final String code;
  const CustomPlatformException(this.code);

  String get message {
    switch (code) {
      case 'network_error':
        return 'Network error. Please check your connection.';
      default:
        return 'A platform-related error occurred.';
    }
  }
}

class CustomFirebaseException implements Exception {
  final String code;
  CustomFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown error occurred. Please try again.';
      case 'email-already-in-use':
        return 'This email is already registered. Please use another email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-verification-code':
        return 'The verification code is invalid. Please check and try again.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please request a new one.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'requires-recent-login':
        return 'Please log in again before performing this action.';
      case 'account-exists-with-different-credential':
        return 'An account with this email already exists but with a different sign-in method.';
      case 'user-token-expired':
      case 'user-token-revoked':
        return 'Your session has expired. Please log in again.';
      case 'network-request-failed':
        return 'Network error occurred. Please check your connection.';
      case 'timeout':
        return 'The operation timed out. Please try again.';
      default:
        return 'An authentication error occurred. Please try again.';
    }
  }

  @override
  String toString() => 'FirebaseException: $message';
}

