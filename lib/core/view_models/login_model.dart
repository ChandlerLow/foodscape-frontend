import 'package:frontend/core/services/authentication_service.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

import 'base_model.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String errorMessage;

  Future<bool> login(String username, String password) async {
    setState(ViewState.Busy);

    final bool success = await _authenticationService.login(username, password);
    if (!success) {
      errorMessage = '';
    }

    setState(ViewState.Idle);
    return success;
  }
}
