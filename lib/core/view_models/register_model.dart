import 'package:frontend/core/services/authentication_service.dart';
import 'package:frontend/core/view_models/base_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/locator.dart';

class RegisterModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String errorMessage;

  Future<bool> register(
    String fullName,
    String username,
    String password,
    String location,
    String phoneNum,
  ) async {
    setState(ViewState.Busy);

    final bool success = await _authenticationService.register(
        fullName, username, password, location, phoneNum);
    if (!success) {
      errorMessage = '';
    }

    setState(ViewState.Idle);
    return success;
  }
}
