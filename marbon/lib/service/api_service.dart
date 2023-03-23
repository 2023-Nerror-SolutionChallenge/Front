import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();

class ApiService {
  static const String baseUrl = "http://34.64.46.40/api/v1";
  //static const String baseUrl = https://localhost:8080/api/v1

  // Post Login
  Future<dynamic> postLogin(String email, password) async {
    try {
      final url = Uri.parse('$baseUrl/auth/login');
      final response = await http.post(
        url,
        body: jsonEncode({
          // jsonEncode 빼고 넣을 것이나/ jsonEncode 넣을것이냐/ header 넣을것이냐
          "id": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        logger.d(data["msg"]);
        return {
          "nick": data['nickname'],
          "pw": data['password'],
          "deleteCount": data["deleteCount"],
          "totalCount": data['totalCount'],
          "badgeList": data["badgeList"],
        };
      } else {
        logger.d('등록되지 않은 이메일이거나 틀린 번호입니다');
        return null;
      }
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  // Post Signup
  Future<dynamic> postSignup(String email, password, nickname) async {
    try {
      final url = Uri.parse('$baseUrl/auth/signup');
      final response = await http.post(
        url,
        body: jsonEncode({
          "id": email,
          "password": password,
          "nickname": nickname,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        logger.d(data["msg"].toString());
        // access, refresh 토큰 헤더에 넣어 응답한거 넘겨야 할 듯
      } else if (response.statusCode == 409) {
        logger.d("중복 닉네임 혹은 이미 가입되어 있음");
      } else {
        logger.d('오류 ${response.statusCode}');
      }
    } catch (e) {
      logger.d(e.toString());
    }
  }

  // 이메일 인증 요청 (로그 나오는거 보고 리턴값 String으로 변환할것 Future<String>으로)
  Future<dynamic> postEmail(String email) async {
    try {
      final url = Uri.parse('$baseUrl/auth/confirm');
      final response = await http.post(url,
          headers: <String, String>{
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
          body: jsonEncode(
            {
              "id": email,
            },
          ));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        logger.d(data["AuthenticationCode"]);
        return data["AuthenticationCode"];
      } else {
        logger.d("실패 : ${response.statusCode}");
        logger.d((response.body).toString());
      }
    } catch (e) {
      logger.d("Error : ${e.toString()}");
    }
  }
}
