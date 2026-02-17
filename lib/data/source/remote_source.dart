import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ums/core/api_constants.dart';

import '../model/auth_model.dart';
import '../model/user_model.dart';

abstract class RemoteSource {
  Future<AuthModel> signIn(String username, String password);

  Future<AuthModel> signUp(String email, String username, String password);

  Future<UserModel> getUserInfo();
}

class RemoteSourceImpl extends RemoteSource {
  final http.Client client;
  RemoteSourceImpl(this.client);

  @override
  Future<UserModel> getUserInfo() async {
    try {
      final response = await client.get(
        Uri.parse(ApiConstants.baseurl + ApiConstants.getUserInfoEndpoint),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return UserModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load user info');
      }
    } catch (e) {
      log(' Error fetching user info: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  @override
  Future<AuthModel> signIn(String username, String password) async {
    try {
      log('body: ${jsonEncode({'email': username, 'password': password})}');
      final response = await client.post(
        Uri.parse(ApiConstants.baseurl + ApiConstants.loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );
      log('login response: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        return AuthModel.fromJson(jsonResponse);
      } else {
        throw Exception(response.reasonPhrase ?? 'Failed to sign in');
      }
    } catch (e) {
      log(' Error signing in: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  @override
  Future<AuthModel> signUp(
    String email,
    String username,
    String password,
  ) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.baseurl + ApiConstants.registerEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'username': username,
          'password': password,
        }),
      );
      log('response: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        return AuthModel.fromJson(jsonResponse);
      } else {
        throw Exception(response.reasonPhrase ?? 'Failed to sign up');
      }
    } catch (e) {
      log(' Error signing up: ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
