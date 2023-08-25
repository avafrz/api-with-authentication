import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider with ChangeNotifier {
  static late SharedPreferences prefs;
  bool isInit = false;
  String _phoneNo = '';
  String _accesstoken = '';
  String _refreshtoken = '';
  String get phoneNo => _phoneNo;
  String get accesstoken => _accesstoken;
  String get refreshtoken => _refreshtoken;

  Future<void> init(BuildContext context) async {
    if (isInit == false) {
      prefs = await SharedPreferences.getInstance();
      notifyListeners();
      isInit = true;
    }
  }

  void savephoneNo(String phoneNo) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNo', phoneNo);
    notifyListeners();
  }

  String getphoneNo() {
    if (prefs.containsKey('phoneNo')) {
      String data = prefs.getString('phoneNo')!;
      _phoneNo = data;
      notifyListeners();
      return data;
    } else {
      _phoneNo = '';
      notifyListeners();
      return '';
    }
  }

  void saveAccessToken(String accesstoken) async {
    prefs.setString('accesstoken', accesstoken);
  }

  String getAccessToken() {
    return prefs.getString('accesstoken') ?? '';
  }

  void saveRefreshToken(String refreshtoken) async {
    prefs.setString('refreshtoken', refreshtoken);
  }

  String getRefreshToken() {
    return prefs.getString('refreshToken') ?? '';
  }
}
