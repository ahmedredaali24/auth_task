import 'package:auth_app/view/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route)=>false);
              },
              icon: const Icon(Icons.exit_to_app_outlined))
        ],
        title: const Text("Home screen"),
      ),
      body: const Center(
        child: Text(
          "welcome",
          style: TextStyle(color: Colors.red, fontSize: 45),
        ),
      ),
    );
  }
}
