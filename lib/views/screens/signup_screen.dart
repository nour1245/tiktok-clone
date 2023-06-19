import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth.dart';

import '../widgets/constants.dart';
import '../widgets/text_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
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
                    'Register',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://icon-library.com/images/person-png-icon/person-png-icon-29.jpg'),
                        backgroundColor: Colors.black,
                      ),
                      Positioned(
                        left: 80,
                        bottom: -10,
                        child: IconButton(
                          onPressed: () {
                            AuthController.instance.pickImage();
                          },
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: media.width,
                    margin: EdgeInsetsDirectional.only(
                        start: media.width * 0.05, end: media.width * 0.05),
                    child: TextInputField(
                      controller: usernamecontroller,
                      hintText: 'User',
                      isObscure: false,
                      icon: Icons.person,
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
                        AuthController.instance.registerUser(
                          usernamecontroller.text,
                          passwordcontroller.text,
                          emailcontroller.text,
                          AuthController.instance.profilePic,
                        );
                      },
                      child: const Text(
                        'Register',
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
                        'you have account?',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20, color: buttoncolor),
                        ),
                      ),
                    ],
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
