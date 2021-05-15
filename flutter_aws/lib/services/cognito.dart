import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_aws/models/user.dart';
import 'package:flutter_aws/services/awsConfiguration.dart';

class Cognito {
  final AWSConfiguration _configuration = AWSConfiguration();

  Future<bool> signUp(User user) async {
    var signUpResponse = await _configuration.auth
        .signUp(
            request: SignUpRequest(
                username: user.userName,
                password: user.password,
                options: CognitoSignUpOptions(
                    userAttributes: {'email': user.email})))
        .onError((error, stackTrace) => _handleErrors(error, stackTrace));

    return signUpResponse.isSignUpComplete;
  }

  Future<bool> confirmSignUp(String username, String token) async {
    var response = await _configuration.auth
        .confirmSignUp(
          request:
              ConfirmSignUpRequest(username: username, confirmationCode: token),
        )
        .onError((error, stackTrace) => _handleErrors(error, stackTrace));
    return response.isSignUpComplete;
  }

  Future<bool> signIn(String username, String password) async {
    var response = await _configuration.auth
        .signIn(
            request: SignInRequest(
                username: username,
                password: password,
                options: CognitoSignInOptions()))
        .onError((error, stackTrace) => _handleErrors(error, stackTrace));
    return response.isSignedIn;
  }

 static fetchAuthSession() async {
    CognitoAuthSession response = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true)).onError((error, stackTrace) => _handleErrors(
        error, stackTrace));
    return response;
  }

  signOut(){
    Amplify.Auth.signOut().onError((error, stackTrace) => _handleErrors(error, stackTrace));
  }

  static _handleErrors(error, stackTrace) {
    print(error);
    print(stackTrace);
  }
}
