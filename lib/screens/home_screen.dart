import 'package:flutter/material.dart';
import 'package:loginwithcode/model/data.dart';
import 'package:loginwithcode/providers/api_handler.dart';
import 'package:loginwithcode/providers/tokenProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const routename = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  bool start = false;
  late TokenProvider tokenProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tokenProvider = context.read<TokenProvider>();
    context.read<TokenProvider>().init(context).then((value) {
      setState(() {
        start = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !start
          ? Center()
          : Consumer2<ApiHandler, TokenProvider>(
              builder: (context, ApiHandler apiHandler, tokenProvider, child) {
                apiHandler = context.read<ApiHandler>();
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: FutureBuilder<Users>(
                    future: apiHandler.userData(context,
                        TokenProvider.prefs.getString('accessToken') ?? ''),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.valueOrDefault.data[0].name);
                      } else {
                        print(snapshot.error);
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
