import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/auth.dart';
import 'package:tiktok_clone/views/widgets/constants.dart';
import 'package:tiktok_clone/views/widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'BetterTok',
            style: TextStyle(
              fontSize: 35,
              color: buttoncolor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: media.width,
            margin: EdgeInsetsDirectional.only(
                start: media.width * 0.05, end: media.width * 0.05),
            child: TextInputField(
              controller: emailcontroller,
              hintText: 'Email',
              isObscure: false,
              icon: Icons.email,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: media.width,
            margin: EdgeInsetsDirectional.only(
                start: media.width * 0.05, end: media.width * 0.05),
            child: TextInputField(
              controller: passwordcontroller,
              hintText: 'Password',
              isObscure: true,
              icon: Icons.lock,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              color: buttoncolor,
              borderRadius: BorderRadius.circular(5),
            ),
            width: media.width * 0.9,
            child: TextButton(
              onPressed: () {
                AuthController.instance
                    .loginUser(emailcontroller.text, passwordcontroller.text);
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have account?',
                style: TextStyle(fontSize: 20),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20, color: buttoncolor),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
