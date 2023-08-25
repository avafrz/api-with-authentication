import 'package:flutter/material.dart';
import 'package:loginwithcode/providers/tokenProvider.dart';
import 'package:loginwithcode/screens/code_screen.dart';
import 'package:loginwithcode/screens/home_screen.dart';
import 'package:loginwithcode/screens/phoneNo_screen.dart';
import 'package:provider/provider.dart';

import 'providers/api_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
        ChangeNotifierProvider(create: (_) => ApiHandler()),
        ChangeNotifierProvider(create: (_) => TokenProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          PhoneNoScreen.routename : (ctx) => PhoneNoScreen(),
          CodeScreen.routename : (ctx) => CodeScreen(),
          HomeScreen.routename : (ctx) => HomeScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: PhoneNoScreen(),
      
    );
  }
}
