import 'package:hjvyas/api/models/HomeMediaResponse.dart';
import 'package:hjvyas/api/models/StaticPageResponse.dart';
import 'package:hjvyas/api/services/HJVyasApiService.dart';

import '../api/models/CategoryListResponse.dart';
import '../api/models/LogoResponse.dart';

class HJVyasRepository {
  final HJVyasApiService _userService;

  HJVyasRepository(this._userService);

  Future<LogoResponse> logo() async {
    return await _userService.logo();
  }

  Future<StaticPageResponse> getStaticpage() async {
    return await _userService.getStaticpage();
  }

  Future<CategoryListResponse> getCategory() async {
    return await _userService.getCategory();
  }

  Future<HomeMediaResponse> homeMediaApi(String start, String end) async {
    return await _userService.homeMediaApi(start, end);
  }
}
