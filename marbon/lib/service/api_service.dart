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
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "id": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        var head = response.headers;
        String accessToken = head["access_token"].toString();
        String refreshToken = head["refresh_token"].toString();

        // 뱃지 정보를 리스트로 가공
        List<int> badgeList = [0, 0, 0, 0, 0, 0];
        var badgeMatch = [
          "MAIL_RICH",
          "STARTERS",
          "ENVIRONMENTAL_MODEL",
          "ENVIRONMENTAL_TUTELARY",
          "EARTH_TUTELARY",
          "MARBON_MARATHONER"
        ];
        if (data['badgeList'] != null) {
          data['badgeList'].forEach(
              (String badge) => {badgeList[badgeMatch.indexOf(badge)] = 1});
        }

        logger.d("deleteCount ${data['deletedCount']}");

        return {
          "flag": true,
          "id": data['id'],
          "nick": data['nickname'],
          "pw": data['password'],
          "deleteCount": data["deletedCount"],
          "totalCount": data['totalCount'],
          "currentLevel": data['currentLevel'],
          "mailAccounts": data["accountList"],
          "badgeList": badgeList,
          "accessToken": accessToken,
          "refreshToken": refreshToken
        };
      } else {
        logger.d('등록되지 않은 이메일이거나 틀린 번호입니다');
        return {"flag": false};
      }
    } catch (e) {
      logger.d(e.toString());
      return {"flag": false};
    }
  }

  // Post Signup
  Future<dynamic> postSignup(String email, password, nickname) async {
    try {
      final url = Uri.parse('$baseUrl/auth/signup');
      final response = await http.post(
        url,
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "id": email,
          "password": password,
          "nickname": nickname,
        }),
      );

      if (response.statusCode == 200) {
        var head = response.headers;
        String accessToken = head["access_token"].toString();
        String refreshToken = head["refresh_token"].toString();
        return {"accessToken": accessToken, "refreshToken": refreshToken};
      } else if (response.statusCode == 409) {
        logger.d("중복 닉네임 혹은 이미 가입되어 있음");
        return {"accessToken": "", "refreshToken": ""};
      } else {
        logger.d('오류 ${response.statusCode}');
        return {"accessToken": "", "refreshToken": ""};
      }
    } catch (e) {
      logger.d(e.toString());
    }
  }

  // 이메일 인증 요청 (로그 나오는거 보고 리턴값 String으로 변환할것 Future<String>으로)
  Future<dynamic> postEmail(String email) async {
    try {
      final url = Uri.parse('$baseUrl/auth/confirm');
      final response = await http.post(
        url,
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "email": email,
          },
        ),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        logger.d(data["AuthenticationCode"]);
        return data["AuthenticationCode"];
      } else {
        logger.d((response.body).toString());
        return "";
      }
    } catch (e) {
      logger.d("Error : ${e.toString()}");
    }
  }

  Future<bool> modifyPassword(String email, password) async {
    try {
      final url = Uri.parse('$baseUrl/auth/modify/pw');
      final response = await http.post(
        url,
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "id": email.toString(),
          "password": password.toString(),
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        logger.d('오류 ${response.statusCode}');
        return false;
      }
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> modifyNick(String email, nick) async {
    try {
      final url = Uri.parse('$baseUrl/auth/modify/nickname');
      final response = await http.post(
        url,
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "id": email,
          "nickname": nick,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        logger.d('오류 ${response.statusCode}');
        return false;
      }
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }
}
