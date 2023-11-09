import '../../../constants/endpoints.dart';
import '../../../models/userModels.dart';
import '../../../services/http_manager.dart';
import '../result/auth_result.dart';
import 'auth_errors.dart' as authErros;

AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
  if (result["result"] != null) {
    final UserModel user = UserModel.fromMap(result["result"]);
    return AuthResult.sucess(user);
  } else {
    return AuthResult.error(authErros.authErrosString(result["error"]));
  }
}

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
        urlEndPonit: Endpoints.validateToken,
        method: HttMethods.post,
        headers: {
          "X-Parse-Session-Token": token,
        });

    return handleUserOrError(result);
  }

  Future<bool> changePassword(
      {required String email,
      required String currentPassword,
      required String newPassword,
      required String token}) async {

    final result = await _httpManager.restRequest(
      urlEndPonit: Endpoints.changePassword,
      method: HttMethods.post,
      body: {
        "email": email,
        "currentPassword": currentPassword,
        "newPassword": newPassword
      },
      headers: {"X-Parse-Session-Token": token},
    );

    return result["error"] == null;
  }

  Future<AuthResult> signin({required email, required password}) async {
    final result = await _httpManager.restRequest(
        urlEndPonit: Endpoints.signin,
        method: HttMethods.post,
        body: {"email": email, "password": password});

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
        urlEndPonit: Endpoints.signup,
        method: HttMethods.post,
        body: user.toMap());

    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
        urlEndPonit: Endpoints.resetPassword,
        method: HttMethods.post,
        body: {"email": email});
  }
}
