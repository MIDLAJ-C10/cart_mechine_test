import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/auth_model.dart';
import '../../../models/login_response_model.dart';

class AuthRepository {
  final String baseUrl = "https://fakestoreapi.com";

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final url = Uri.parse("$baseUrl/auth/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (kDebugMode) {
      print("Raw response: ${response.body}");
    } // Debug log

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);

      if (data["token"] != null && data["token"].toString().isNotEmpty) {
        final loginResponse = LoginResponseModel.fromJson(data);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", loginResponse.token);

        return loginResponse; // ✅ success
      } else {
        throw Exception("Login failed: token not found");
      }
    } else {
      throw Exception("HTTP ${response.statusCode}: ${response.body}");
    }

  }

}
