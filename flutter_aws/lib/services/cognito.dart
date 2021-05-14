import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
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

  _handleErrors(error, stackTrace) {
    print(error);
    print(stackTrace);
  }
}
