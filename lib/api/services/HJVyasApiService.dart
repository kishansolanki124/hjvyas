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
import '../models/AddOrderResponse.dart';
import '../models/CategoryListResponse.dart';
import '../models/ContactusResponse.dart';
import '../models/LogoResponse.dart';
import '../models/ProductDetailResponse.dart';
import '../models/ProductListResponse.dart';
import '../models/ProductTesterResponse.dart';
import '../models/ShippingChargesResponse.dart';
import '../models/ShippingStatusResponse.dart';
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
      final formData = {'product_id': productId};

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
      );
      if (kDebugMode) {
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
      final formData = {'combo_id': productId};

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
      );
      if (kDebugMode) {
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

  Future<ShippingStatusResponse> getShippingStatus() async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      final response = await _client.post('/get_shipping_status');
      if (kDebugMode) {
        print('response is $response');
      }
      return ShippingStatusResponse.fromJson(jsonDecode(response.data));
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

  Future<ShippingChargesResponse> getShippingCharge(
    String city_jamnagar,
    String city_other,
    String state_outof_gujarat,
    String country_outside,
    String cart_weight,
    String cart_amount,
  ) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {
        'city_jamnagar': city_jamnagar,
        'city_other': city_other,
        'state_outof_gujarat': state_outof_gujarat,
        'country_outside': country_outside,
        'cart_weight': cart_weight,
        'cart_amount': cart_amount,
      };

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/get_shipping_charge',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      if (kDebugMode) {
        print('response is $response');
      }
      return ShippingChargesResponse.fromJson(jsonDecode(response.data));
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

  Future<ShippingChargesResponse> addRazorpayStatus(
    String order_no,
    String razorpay_orderid,
    String razorpay_paymentid
  ) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {
        'order_no': order_no,
        'razorpay_orderid': razorpay_orderid,
        'razorpay_paymentid': razorpay_paymentid,
      };

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/add_razorpay_status',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      if (kDebugMode) {
        print('response is $response');
      }
      return ShippingChargesResponse.fromJson(jsonDecode(response.data));
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

  Future<AddOrderResponse> addOrder(
    String customer_name,
    String customer_email,
    String contact_no,
    String alternate_contact_no,
    String delivery_address,
    String postal_code,
    String country,
    String state,
    String city,
    String gift_sender,
    String gift_sender_mobile,
    String gift_receiver,
    String gift_receiver_mobile,
    String product_tester_id,
    String order_amount,
    String shipping_charge,
    String transaction_charge,
    String payment_type,
    String platform,
    String product_id,
    String product_type,
    String product_name,
    String packing_id,
    String packing_weight,
    String packing_weight_type,
    String packing_quantity,
    String packing_price,
    String notes,
  ) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {
        'customer_name': customer_name,
        'customer_email': customer_email,
        'contact_no': contact_no,
        'alternate_contact_no': alternate_contact_no,
        'delivery_address': delivery_address,
        'postal_code': postal_code,
        'country': country,
        'state': state,
        'city': city,
        'gift_sender': gift_sender,
        'gift_sender_mobile': gift_sender_mobile,
        'gift_receiver': gift_receiver,
        'gift_receiver_mobile': gift_receiver_mobile,
        'product_tester_id': product_tester_id,
        'order_amount': order_amount,
        'shipping_charge': shipping_charge,
        'transaction_charge': transaction_charge,
        'payment_type': payment_type,
        'platform': platform,
        'product_id': product_id,
        'product_type': product_type,
        'product_name': product_name,
        'packing_id': packing_id,
        'packing_weight': packing_weight,
        'packing_weight_type': packing_weight_type,
        'packing_quantity': packing_quantity,
        'packing_price': packing_price,
        'notes': notes,
      };

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/add_order',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      if (kDebugMode) {
        print('response is $response');
      }
      return AddOrderResponse.fromJson(jsonDecode(response.data));
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

  Future<ProductTesterResponse> getProductTester(
    String cartProductId,
    String cartTotal,
  ) async {
    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {
        'cart_product_id': cartProductId,
        'cart_total': cartTotal,
      };

      if (kDebugMode) {
        print('formData is: $formData');
      }

      final response = await _client.post(
        '/get_product_tester',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      if (kDebugMode) {
        print('response is $response');
      }
      return ProductTesterResponse.fromJson(jsonDecode(response.data));
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
