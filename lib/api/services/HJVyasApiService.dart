import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hjvyas/api/api_client.dart';
import 'package:hjvyas/api/models/AddInquiryResponse.dart';
import 'package:hjvyas/api/models/ComboDetailResponse.dart';
import 'package:hjvyas/api/models/ComboListResponse.dart';
import 'package:hjvyas/api/models/HomeMediaResponse.dart';
import 'package:hjvyas/api/models/ProductCartResponse.dart';

import '../ConnectivityService.dart';
import '../exceptions/exceptions.dart';
import '../models/CategoryListResponse.dart';
import '../models/ContactusResponse.dart';
import '../models/LogoResponse.dart';
import '../models/ProductDetailResponse.dart';
import '../models/ProductListResponse.dart';
import '../models/StaticPageResponse.dart';

class HJVyasApiService {
  final Dio _client = apiClient;

  HJVyasApiService(Dio dio);

  Future<LogoResponse> logo() async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      final response = await _client.post('/get_logo');
      if (kDebugMode) {
        print('response is $response');
      }
      return LogoResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }

  Future<StaticPageResponse> getStaticpage() async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      final response = await _client.post('/get_staticpage');
      if (kDebugMode) {
        print('response is $response');
      }
      return StaticPageResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }

  Future<ContactusResponse> getContactus() async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      final response = await _client.post('/get_contactus');
      if (kDebugMode) {
        print('response is $response');
      }
      return ContactusResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }

  Future<ProductDetailResponse> getProductDetail(String productId) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {
        'product_id': productId,
      };

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/get_product_detail',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );      if (kDebugMode) {
        print('response is $response');
      }
      return ProductDetailResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }

  Future<ComboDetailResponse> getComboDetail(String productId) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {
        'combo_id': productId,
      };

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/get_combo_detail',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );      if (kDebugMode) {
        print('response is $response');
      }
      return ComboDetailResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }

  Future<CategoryListResponse> getCategory() async {
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      final response = await _client.post('/get_category');
      if (kDebugMode) {
        print('response is $response');
      }
      return CategoryListResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }

  Future<HomeMediaResponse> homeMediaApi(String start, String end) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {'start': start, 'end': end};

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/get_slider',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      if (kDebugMode) {
        print('response is $response');
      }
      return HomeMediaResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }

  Future<AddInquiryResponse> addInquiry(
    String inquiry_type,
    String name,
    String contact_no,
    String email,
    String city,
    String message,
  ) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {
        'inquiry_type': inquiry_type,
        'name': name,
        'contact_no': contact_no,
        'email': email,
        'city': city,
        'message': message,
      };

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/add_inquiry',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      if (kDebugMode) {
        print('response is $response');
      }
      return AddInquiryResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }

  Future<AddInquiryResponse> addNotifyMe(
    String product_id,
    String product_type,
    String user_mobile,
    String user_email,
  ) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {
        'product_id': product_id,
        'product_type': product_type,
        'user_mobile': user_mobile,
        'user_email': user_email,
      };

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/add_notify_me',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      if (kDebugMode) {
        print('response is $response');
      }
      return AddInquiryResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }

  Future<ProductCartResponse> getProductCart(
    String cart_packing_id,
    String cart_product_type,
  ) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {
        'cart_packing_id': cart_packing_id,
        'cart_product_type': cart_product_type,
      };

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/get_product_cart',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      if (kDebugMode) {
        print('response is $response');
      }
      return ProductCartResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }

  Future<ProductListResponse> getProduct(
    String start,
    String end,
    int categoryId,
  ) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {'start': start, 'end': end, 'category_id': categoryId};

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/get_product',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      if (kDebugMode) {
        print('response is $response');
      }
      return ProductListResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }

  Future<ComboListResponse> getCombo(String start, String end) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {'start': start, 'end': end};

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/get_combo',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      if (kDebugMode) {
        print('response is $response');
      }
      return ComboListResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException is message ${e.message} and error is ${e.error}');
      }
      if (e.response != null) {
        if (kDebugMode) {
          print('DioException is response ${e.response}');
          print('e.response!.statusCode ${e.response!.statusCode!}');
        }
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        throw NetworkException('No internet connection');
      }
    }
  }
}
