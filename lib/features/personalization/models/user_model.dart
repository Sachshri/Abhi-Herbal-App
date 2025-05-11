import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_flutter_app/utils/formaters/formaters.dart';

class UserModel {
  final String id;
  final String email;
  final String username;
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePicture;
  String role;
  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profilePicture,
    required this.role,
  });

  // Helper Function to get full name
  String get fullName => '$firstName $lastName';

  //Helper function to get format phone number
  String get formattedPhoneNumber => Formaters.formatPhoneNumber(phoneNumber);

  // Split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(' ');
  //Static function to generate user name from full name
  static String generateUsername(String fullName) {
    final name = fullName.split(' ');
    String firstName = name[0].toLowerCase();
    String lastName =
        name.length > 1 ? name.sublist(1).join().toLowerCase() : '';

    String camelCaseName = '$firstName$lastName';
    String usernameWithPrefix = '@$camelCaseName';
    return usernameWithPrefix;
  }

  //Static function to create an empty user model
  static UserModel empty() {
    return UserModel(
      id: '',
      email: '',
      username: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
      profilePicture: '',
      role: '',
    );
  }

  // Convert UserModel to a Map (for Firestore storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'role': role,
    };
  }

  // Create a UserModel from a Firestore document
  factory UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final map = document.data()!;
      return UserModel(
        id: map['id'] ?? '',
        email: map['email'] ?? '',
        username: map['username'] ?? '',
        firstName: map['firstName'] ?? '',
        lastName: map['lastName'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        profilePicture: map['profilePicture'] ?? '',
        role: map['role'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
