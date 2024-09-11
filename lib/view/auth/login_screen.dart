
import 'package:auth_app/view/auth/firebase_utils.dart';
import 'package:auth_app/view/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_color.dart';
import '../../utils/primary_button.dart';
import '../../utils/text_form_widget.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/LoginScreen";

   LoginScreen({super.key});


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController mailController =
  TextEditingController(text: "ahmedreda@gmail.com");

  final TextEditingController passwordController =
  TextEditingController(text: "Aa123456789ahmed");

  bool isPasswordStrong(String password) {
    if (password.length < 8) {
      return false;
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColors.kLightWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 56),
              const Center(
                  child: Text('Sign In',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              const SizedBox(height: 5),
              const Center(
                child: Text('Welcome back! Please enter your details',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: Colors.black)),
              ),
              const SizedBox(height: 68),
              AuthField(
                  controller: mailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!value.isEmail) {
                      return 'Please enter a valid email address';
                    }

                    return null;
                  },
                  hintText: 'Email address'),
              const SizedBox(height: 16),
              AuthField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (!isPasswordStrong(value)) {
                      return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit.';
                    }
                    return null;
                  },
                  hintText: 'Password'),
              const SizedBox(height: 60),
              PrimaryButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                    FirebaseUtils.login(mailController.text, passwordController.text,context);
                    }
                  },
                  text: 'SIgn In'),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Create your account:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  PrimaryButton(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
                    },
                    text: 'Sign UP',
                    height: 50,
                    width: 200,
                    fontColor: Colors.white,
                    btnColor: Colors.red,
                    fontSize: 12,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
