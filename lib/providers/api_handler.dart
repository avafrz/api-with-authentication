import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loginwithcode/model/data.dart';
import 'package:loginwithcode/providers/tokenProvider.dart';

class ApiHandler with ChangeNotifier {
  Dio dio = Dio()
    ..interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      print('___________________________________________________');
      print("error: ${error.toString()}\n");
      handler.reject(error);
    }, onRequest: (request, handler) {
      print('___________________________________________________');
      print(
          'token is ==>>  ${TokenProvider.prefs.getString('accessToken')} *****');
      print('___________________________________________________');
      print(
          'token is ==>>  ${TokenProvider.prefs.getString('accessToken')} *****');
      try {
        if (TokenProvider.prefs.getString('accessToken') != null) {
          request.headers['Authorization'] =
              'Bearer ${TokenProvider.prefs.getString('accessToken')}';
        }
        request.headers['Content-Type'] = 'application/json';
        request.headers['BusinessKey'] = '1da5ce01-7491-44a2-a823-2f4734ef0aef';
        print('___________________________________________________');
        print(
          'Request=> ${request.baseUrl}${request.path}'
          '\n'
          'Body => ${request.data}'
          '\n'
          'Params => ${request.queryParameters}'
          '\n',
        );
        handler.next(request);
      } catch (e) {
        print('___________________________________________________');
        print(
            "request error => ${request.path} \ndata: ${request.data.toString()}\n");
      }
    }, onResponse: (response, handler) async {
      print(
        'Response=> ${response.realUri} '
        '\n'
        'Data => ${response.data}'
        '\n'
        'Extra => ${response.extra}',
      );
      // if (response.statusCode == 401) {
      //   ApiHandler()
      //       .refreshToken(TokenProvider.prefs.getString('refreshToken') ?? '');
      // }
      handler.resolve(response);
    }));

  Future<void> enterPhone(BuildContext context, String phoneNo) async {
    final response = await dio.post(
      'https://sit-bnpl.saminray.com/usermanagementnew/Auth/SendCode',
      data: {
        'phoneNo': phoneNo,
      },
    );

    if (response.statusCode == 200) {
      notifyListeners();
      print(response.data);
      TokenProvider.prefs.setString('phoneNo', phoneNo);
    } else {
      print(response.data['reasons']);
    }
  }

  Future<void> sendCode(
      BuildContext context, String phoneNo, int loginCode) async {
    final response = await dio.post(
      'https://sit-bnpl.saminray.com/usermanagementnew/Auth/Login',
      data: {
        'phoneNo': phoneNo,
        'loginCode': loginCode,
      },
    );
    if (response.statusCode == 200) {
      print(response.data);

      TokenProvider.prefs.setString('accessToken',
          response.data['valueOrDefault']['tokens']['accesstoken']);
      TokenProvider.prefs.setString('refreshToken',
          response.data['valueOrDefault']['tokens']['refreshtoken']);
    }
  }

  Future<void> refreshToken(String refreshToken) async {
    final response = await dio.post(
        'https://sit-bnpl.saminray.com/usermanagementnew/Auth/Refresh',
        data: {
          'refreshToken': refreshToken,
        });
    TokenProvider.prefs.setString('accessToken',
        response.data['valueOrDefault']['tokens']['accessToken']);
  }

  Future<Users> userData(BuildContext context, String token) async {
    final response = await dio.get(
      'https://sit-bnpl.saminray.com/apiappnew/Merchant/SearchMerchant?hasPaging=true&_page=1&_limit=10',
    );
    if (response.statusCode == 200) {
      var myUser = Users.fromJson(response.data);
      print(myUser);
      return myUser;
    } else {
      throw Exception('Failed to load user');
    }
  }
}
