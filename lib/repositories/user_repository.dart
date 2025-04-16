import 'package:hjvyas/api/services/hjvyas_api_service.dart';

import '../api/models/LogoResponse.dart';

class HJVyasRepository {
  final HJVyasApiService _userService;

  HJVyasRepository(this._userService);

  Future<LogoResponse> getUser() async {
    return await _userService.logo();
  }
}
