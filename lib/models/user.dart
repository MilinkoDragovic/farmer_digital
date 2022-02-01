import 'dart:io';

class User {
  String email;

  String firstName;

  String lastName;

  String userID;

  String appIdentifier;

  String mobileNumber;

  User({
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.userID = '',
    this.mobileNumber = '',
  }) : appIdentifier = 'Flutter Login Screen ${Platform.operatingSystem}';
}
