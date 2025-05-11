import 'package:intl/intl.dart';

class Formaters {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_IN', symbol: '\u{20B9}')
        .format(amount);
  }
//Assuming phone number be a 10 digit 8769788996
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '${phoneNumber.substring(0, 5)} ${phoneNumber.substring(5)}}';
    } else if (phoneNumber.length == 12) {
      //if phone number is of 13 length 918769788996
      return '(${phoneNumber.substring(0, 2)}) ${phoneNumber.substring(2, 7)} ${phoneNumber.substring(7)}';
    }
    //else 
    return phoneNumber;
  }

}
