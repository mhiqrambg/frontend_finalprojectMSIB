import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
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
    final url = Uri.parse(
        '${Config.apiUrl + Config.userAPI}/signup'); // Sesuaikan dengan endpoint register di server Anda
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
}
