// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison

import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String pwd;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(
            builder: (context) => Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 200,
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                  ),
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Email',
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Password',
                    ),
                    onChanged: (value) {
                      pwd = value;
                    },
                    obscureText: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RoundedButton(
                    label: "Login",
                    onPressed: () async {
                      try {
                        final progress = ProgressHUD.of(context)!;
                        progress.show();
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: pwd);
                        if (user != null) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, ChatScreen.id, (route) => false);
                        }
                        progress.dismiss();
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
