import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:farmer_digital/models/user.dart';

class AmplifyUtils {
  /// login with email and password with amplify
  /// @param email user email
  /// @param password user password
  static Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      // SignInResult result = await Amplify.Auth.signIn(
      //   username: email,
      //   password: password,
      // );
      String result = 'dsadsa';

      return result;
    } on AuthException catch (e) {
      if (e.message.contains('already a user which is signed in')) {
        // await Amplify.Auth.signOut();
        return 'Problem logging in. Please try again.';
      }
      return e.message;
    }
  }

  static Future<dynamic> signUpWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String firstName,
    required String lastName,
    required String mobileNumber,
  }) async {
    try {
      Map<CognitoUserAttributeKey, String> userAttributes = {
        CognitoUserAttributeKey.email: emailAddress,
        CognitoUserAttributeKey.phoneNumber: mobileNumber,
        CognitoUserAttributeKey.givenName: firstName,
        CognitoUserAttributeKey.familyName: lastName,
        // additional attributes as needed
      };

      SignUpResult result = await Amplify.Auth.signUp(
        username: emailAddress,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );

      User user = User(
        email: emailAddress,
        firstName: firstName,
        lastName: lastName,
        mobileNumber: mobileNumber,
      );

      if (result.isSignUpComplete) {
        return user;
      } else {
        return 'Couldn\'t sign up for amplify, Please try again.';
      }
    } on AuthException catch (e) {
      return e.message;
    }
  }
}
