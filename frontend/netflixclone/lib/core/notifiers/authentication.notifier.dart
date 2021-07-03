import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:netflixclone/app/routes/api.routes.dart';
import 'package:netflixclone/core/api/authentication.api.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

  String otp = "";
  String _useremail = "";
  String get useremail => _useremail;

  ///send Email Verification----------------
  Future sendVerificationEmail({required String userEmail}) async {
    final String subUrl = "/user/send-emial-verification";
    final Uri uri = Uri.parse(BaseUrl + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers, body: jsonEncode({"useremail": userEmail}));
    final String body = response.body;
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      final Map<String, dynamic> parsedData = await jsonDecode(body);
      final bool received = parsedData['received'];
      print(parsedData);
      if (received) {
        final String useremail = parsedData['useremail'];
        _useremail = useremail;
        otp = parsedData['secretcode'];
      } else
        notifyListeners();
      return parsedData;
    }
  }

  ///Verify OTO------------------------------------
  Future verifyOTP({required String userOTP}) async {
    final String subUrl = "/user/verify-email";
    final Uri uri = Uri.parse(BaseUrl + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "secretcode": otp,
          "secretcodeInput": userOTP,
          "useremail": useremail
        }));
    final String body = response.body;
    print(body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      final Map<String, dynamic> parsedData = await jsonDecode(body);
      final bool verified = parsedData['verified'];
      if (verified == true) {
        _useremail = parsedData['useremail'];
      }

      notifyListeners();
      return parsedData;
    }
  }

  ///Save User Details ----------------------
  Future saveData({required String username,required String userPassword}) async {
    final String subUrl = "/user/save-data";
    final Uri uri = Uri.parse(BaseUrl + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "username":username,
          "useremail":useremail,
          "userpassword":userPassword
        }));
    final String body = response.body;
    print(body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      final Map<String, dynamic> parsedData = await jsonDecode(body);
      notifyListeners();
      return parsedData;
    }
  }

///lOGIN-------------------------------------------------
  Future loginNotifier({required String userEmail , required String userPassword}) async {
    final String subUrl = "/user/login";
    final Uri uri = Uri.parse(BaseUrl + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "useremail": userEmail,
          "userpassword": userPassword
        }));
    final String body = response.body;
    print(body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      final Map<String, dynamic> parsedData = await jsonDecode(body);
      notifyListeners();
      return parsedData;
    }
  }



}
