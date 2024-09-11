import 'package:auth_app/view/auth/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/primary_button.dart';
import '../../utils/text_form_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "/RegisterScreen";

  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController mailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

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
      backgroundColor: const Color(0xFFFDFDFD),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 56),
              const Center(
                  child: Text('Sign Up',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              const SizedBox(height: 5),
              const Text('Welcome back! Please enter your details',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: Colors.black)),
              const SizedBox(height: 68),
              AuthField(
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Full Name';
                    } else if (value.contains(RegExp(r'[0-9]'))) {
                      return 'Full Name should not contain digits';
                    }
                    return null;
                  },
                  hintText: 'Full Name'),
              const SizedBox(height: 16),
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
              const SizedBox(height: 95),
              PrimaryButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      FirebaseUtils.register(mailController.text,
                          passwordController.text, context);
                    }
                  },
                  text: 'Sign Up'),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "if you have an account:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  PrimaryButton(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    text: 'Sign IN',
                    height: 50,
                    width: 200,
                    fontColor: Colors.white,
                    btnColor: Colors.red,
                    fontSize: 20,
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
