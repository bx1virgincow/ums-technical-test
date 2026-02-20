import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ums/core/api_constants.dart';
import 'package:ums/core/api_response.dart';
import 'package:ums/core/typedef.dart';
import 'package:ums/feature/bottom_nav/data/model/login_response_model.dart';

import '../model/initiate_reponse.dart';
import '../model/user_model.dart';

abstract class RemoteSource {
  ApiFuture<LoginResponseModel> signIn(String identifier, String otp);

  ApiFuture<String> signUp(String email, String username, String password);

  ApiFuture<UserModel> getUserInfo();

  ApiFuture<InitiateResponse> initiateLogin(String identifier, String password);

  ApiFuture<String> verifyOtp(String email, String otp);
}

class RemoteSourceImpl extends RemoteSource {
  final http.Client client;
  RemoteSourceImpl(this.client);

  @override
  ApiFuture<UserModel> getUserInfo() async {
    try {
      final response = await client.get(
        Uri.parse(ApiConstants.getUserInfoEndpoint),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return ApiResponse.fromJson(
          jsonResponse,
          (json) => UserModel.fromJson(json),
        );
      } else {
        throw Exception('Failed to load user info');
      }
    } catch (e) {
      log(' Error fetching user info: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  @override
  ApiFuture<LoginResponseModel> signIn(String identifier, String otp) async {
    try {
      final response = await client.post(
        Uri.parse(
          '${ApiConstants.loginEndpoint}?identifier=$identifier&otpCode=$otp',
        ),
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
      );
      log('login response: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return ApiResponse.fromJson(
          jsonResponse,
          (json) => LoginResponseModel.fromJson(json),
        );
      } else {
        throw Exception(response.reasonPhrase ?? 'Failed to sign in');
      }
    } catch (e) {
      log(' Error signing in: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  @override
  ApiFuture<String> signUp(
    String email,
    String username,
    String password,
  ) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.registerEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "surname": "Test",
          "givenName": "User",
          "phone": "+233245672244",
          "email": email,
          "role": "CUSTOMER",
          "landmark": "N/A",
          "gpsCode": "GA-123-9876",
          "password": password,
        }),
      );
      log('response: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        return ApiResponse.fromJson(jsonResponse, (json) => json);
      } else {
        throw Exception(response.reasonPhrase ?? 'Failed to sign up');
      }
    } catch (e) {
      log(' Error signing up: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  @override
  ApiFuture<InitiateResponse> initiateLogin(
    String identifier,
    String password,
  ) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.initiateUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'identifier': identifier, 'password': password}),
      );
      log('response here: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log('jsonResponse: $jsonResponse');
        return ApiResponse.fromJson(
          jsonResponse,
          (json) => InitiateResponse.fromJson(json),
        );
      } else {
        throw Exception(response.reasonPhrase ?? 'Failed to initiate login');
      }
    } catch (e) {
      log('exception on initiate: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  @override
  ApiFuture<String> verifyOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.verifyOtpUrl}?email=$email&code=$otp'),
        headers: {'Content-Type': 'application/json'},
      );
      log('verify otp response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log('jsonResponse: $jsonResponse');
        return ApiResponse.fromJson(jsonResponse, (json) => json);
      } else {
        throw Exception(response.reasonPhrase ?? 'Failed to verify OTP');
      }
    } catch (e) {
      log('exception on verify OTP: ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
