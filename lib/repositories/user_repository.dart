import 'package:hjvyas/api/services/user_service.dart';

import '../api/models/LogoResponse.dart';

class UserRepository {
  final UserService _userService;

  UserRepository(this._userService);

  Future<LogoResponse> getUser() async {
    return await _userService.logo();
  }
}
