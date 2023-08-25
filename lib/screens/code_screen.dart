import 'package:flutter/material.dart';
import 'package:loginwithcode/providers/api_handler.dart';
import 'package:loginwithcode/providers/tokenProvider.dart';
import 'package:provider/provider.dart';

import '../widgets/textfield.dart';
import 'home_screen.dart';

class CodeScreen extends StatelessWidget {
  static const routename = '/code_screen';
  const CodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController codeController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(
                  height: constraints.maxHeight * 1 / 2,
                  width: constraints.maxWidth,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(200),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: constraints.maxWidth * 0.82,
                  height: constraints.maxHeight * 0.86,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.38,
                          height: constraints.maxHeight * 0.15,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(120),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 10,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFieldWidget(
                          'Code',
                          'Your Code',
                          codeController,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "* Required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Consumer<ApiHandler>(
                              builder: (context, ApiHandler auth,
                                  child) {
                            return ElevatedButton(
                              onPressed: () {
                                
                                auth.sendCode(context, TokenProvider.prefs.getString('phoneNo') ?? '',
                                    int.parse(codeController.text));
                                    Navigator.of(context).pushNamed(HomeScreen.routename);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                elevation: 0,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  top: 15,
                                  bottom: 10,
                                  left: 20,
                                  right: 20,
                                ),
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
