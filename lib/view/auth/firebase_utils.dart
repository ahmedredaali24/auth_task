import 'package:auth_app/view/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


import 'login_screen.dart';

class FirebaseUtils {
  static dialog(
      {required BuildContext context,
      required String title,
      String routeName = ""}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            actions: [
              Center(
                child: TextButton(
                    onPressed: () {
                      if (routeName == "") {
                        Navigator.pop(context);
                        return;
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            routeName, (route) => false);
                      }
                    },
                    child: const Text('ok')),
              )
            ],
          );
        });
  }

  static register(
      String emailAddress, String password, BuildContext context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      dialog(
          context: context,
          title: "تم انشاء حساب جديد بنجاح",
          routeName: LoginScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        dialog(
          context: context,
          title: "The password provided is too weak",
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        dialog(
          context: context,
          title: "The account already exists for that email",
        );
      }
    } catch (e) {
      print(e);
      dialog(
        context: context,
        title: "error",
      );
    }
  }

  static login(
      String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } catch (e) {
      dialog(
        context: context,
        title: "error:$e",
      );
    }
  }
}
