import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/products/products_response.dart';
import '../models/products/update_request.dart';
import '../models/products/update_response.dart';
import '../models/products/upload_request.dart';
import '../models/products/upload_response.dart';
import '../models/profile_request.dart';
import '../models/profile_response.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';

class ApiService {
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final url = Uri.parse('${Config.apiUrl + Config.userAPI}/signin');
    final response = await http.post(
      url,
      body: jsonEncode(request.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    final url = Uri.parse('${Config.apiUrl + Config.userAPI}/signup');
    final response = await http.post(
      url,
      body: jsonEncode(request.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return RegisterResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<ProfileResponseModel> updateProfile(
      String username, ProfileRequestModel request, String token) async {
    final url =
        Uri.parse('${Config.apiUrl + Config.userAPI}/profile/$username');
    final response = await http.put(
      url,
      body: jsonEncode(request.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ProfileResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update profile');
    }
  }

  static Future<ProductsResponse> getProducts() async {
    final url = Uri.parse('${Config.apiUrl + Config.userAPI}/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ProductsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<UploadResponse> uploadData(UploadRequest request) async {
    final url = Uri.parse('${Config.apiUrl + Config.userAPI}/products');
    final response = await http.post(
      url,
      body: jsonEncode(request.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return UploadResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  static Future<UpdateProductsResponse> updateProduct(
      int productId, UpdateProductRequest updateRequest) async {
    final url =
        Uri.parse('${Config.apiUrl + Config.userAPI}/products/$productId');
    final response = await http.put(
      url,
      body: jsonEncode(updateRequest.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return UpdateProductsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
