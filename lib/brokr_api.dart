import 'dart:convert';
import 'package:http/http.dart' as http;

class BrokrApi {
  final String baseUrl = 'https://staging.brokr.com/api';

  // Token obtained from login or refresh token endpoint
  String bearerToken = '';

  Future<void>? setBearerToken(String token) {
    bearerToken = token;
    return null;
  }


  // Get general information about the API
  Future<Map<String, dynamic>> getGeneralInfo() async {
    final response = await http.get(Uri.parse('$baseUrl/languages'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error retrieving general information');
    }
  }

  // Social login
  Future<Map<String, dynamic>> loginWithSocial(String fcmToken,
      String socialAuth, String type, String language) async {
    final headers = {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };
    final body = {
      'fcm_token': fcmToken,
      'social_auth': socialAuth,
      'type': type,
      'language': language
    };

    final response = await http.post(
        Uri.parse('$baseUrl/auth/login_with_social'), headers: headers,
        body: body);
    if (response.statusCode == 200) {
      await setBearerToken(response.headers['Authorization']!.split(' ')[1]);
      return jsonDecode(response.body);
    } else {
      throw Exception('Error logging in with social');
    }
  }

  // Email login
  Future<Map<String, dynamic>> loginWithEmail(String email, String password,
      String os, String type, String language) async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };
    final body = {
      'email': email,
      'password': password,
      'os': os,
      'type': type,
      'language': language
    };

    final response = await http.post(
        Uri.parse('$baseUrl/auth/login'), headers: headers, body: body);
    if (response.statusCode == 200) {
      await setBearerToken(response.headers['Authorization']!.split(' ')[1]);
      return jsonDecode(response.body);
    } else {
      throw Exception('Error logging in with email');
    }
  }

  // Email registration
  Future<Map<String, dynamic>> registerWithEmail(String name,
      String lastName,
      String birthdate,
      String idCountry,
      String phone,
      String phoneCode,
      String email,
      String password,
      String passwordConfirmation,
      String os,
      String avatar,
      String type,
      String language,) async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };
    final body = {
      'name': name,
      'last_name': lastName,
      'birthdate': birthdate,
      'id_country': idCountry,
      'phone': phone,
      'phone_code': phoneCode,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'os': os,
      'avatar': avatar,
      'type': type,
      'language': language,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error registering user');
    }
  }


  Future<Map<String, dynamic>> refreshToken(String fcmToken) async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };
    final body = {
      'fcm_token': fcmToken
    };

    final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh_token'), headers: headers, body: body);
    if (response.statusCode == 200) {
      await setBearerToken(response.headers['Authorization']!.split(' ')[1]);
      return jsonDecode(response.body);
    } else {
      throw Exception('Error refreshing token');
    }
  }

}
