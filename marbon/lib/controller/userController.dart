import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserController extends GetxController {
  String _id = "";
  String _nick = "";
  String _pw = "";
  String _accessToken = "";
  String _refreshToken = "";
  int _deleteCount = 0;
  int _totalCount = 0;
  int _currentLevel = 0;
  List<int> _badges = [];
  List<dynamic> _mailAccounts = [];

  get id => _id;
  get nick => _nick;
  get pw => _pw;
  get accessToken => _accessToken;
  get refreshToken => _refreshToken;
  get deleteCount => _deleteCount;
  get totalCount => _totalCount;
  get currentLevel => _currentLevel;
  get badges => _badges;
  get mailAccounts => _mailAccounts;

  void upadateUserInform(
      {required String id,
      required String nick,
      required String pw,
      required String accessToken,
      required String refreshToken,
      required int deleteCount,
      required int totalCount,
      required int currentLevel,
      required List<int> badges,
      required List<dynamic> mailAccounts}) {
    _id = id;
    _nick = nick;
    _pw = pw;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _deleteCount = deleteCount;
    _totalCount = totalCount;
    _currentLevel = currentLevel;
    _badges = badges;
    _mailAccounts = mailAccounts;

    update();
  }

  void setNick(String nick) {
    _nick = nick;
    update();
  }
}
