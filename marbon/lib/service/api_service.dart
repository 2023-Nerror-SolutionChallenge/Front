import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();

class ApiService {
  static const String baseUrl = "https://localhost:8080/api/v1";

  // Post Login
  Future<bool> postLogin(String email, password) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        body: {"id": email, "password": password},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        logger.d(data["msg"]);
        return true;
      } else {
        logger.d('등록되지 않은 이메일이거나 틀린 번호입니다');
        return false;
      }
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  // Post Signup
  Future<dynamic> postSignup(
      String email, password, nickname, Image picture) async {
    try {
      final url = Uri.parse('$baseUrl/signup');
      final response = await http.post(
        url,
        body: {
          "id": email,
          "nickname": nickname,
          "password": password,
          "picture": picture
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        logger.d(data["msg"]);
        // access, refresh 토큰 헤더에 넣어 응답한거 넘겨야 할 듯
      } else if (response.statusCode == 409) {
        logger.d("중복 닉네임 혹은 이미 가입되어 있음");
      } else {
        logger.d('오류');
      }
    } catch (e) {
      logger.d(e.toString());
    }
  }

  // 이메일 인증 요청 (로그 나오는거 보고 리턴값 String으로 변환할것 Future<String>으로)
  Future<dynamic> postEmail(String email) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        body: {
          "id": email,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        logger.d(data["AuthenticationCode"]);
        return data["AuthenticationCode"];
      } else {
        logger.d("실패");
      }
    } catch (e) {
      logger.d(e.toString());
    }
  }
}
