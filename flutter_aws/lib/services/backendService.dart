import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_aws/services/cognito.dart';
import 'package:http/http.dart' as http;

class BackendService {
  static Future<String> getWeatherForecast() async {
    CognitoAuthSession session = await Cognito.fetchAuthSession();
    var token = session.userPoolTokens.idToken;
    var headers = {"Authorization": "Bearer $token"};
    var uri = Uri.https("10.0.2.2:44350", "weatherforecast");
    print(uri.toString());
    var response = await http.get(uri, headers: headers).onError((error, stackTrace) => _handleErrors(
        error, stackTrace));
    print(response.statusCode);
    print(response.body);
    return response.body;
  }

  static _handleErrors(error, stackTrace) {
    print(error);
    print(stackTrace);
  }
}
