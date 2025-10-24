import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:5000"; // Use this if testing on Android emulator
  // Use http://localhost:5000 or http://127.0.0.1:5000 for desktop/browser

  // SIGNUP
  static Future<http.Response> signup(String email, String password, String allergies) {
    return http.post(
      Uri.parse("$baseUrl/auth/signup"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password, 'allergies': allergies}),
    );
  }

  // LOGIN
  static Future<http.Response> login(String email, String password) {
    return http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  // SCAN PRODUCT
  static Future<http.Response> scanProduct(String email, String barcode) {
    return http.post(
      Uri.parse("$baseUrl/scan"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'barcode': barcode}),
    );
  }
}
