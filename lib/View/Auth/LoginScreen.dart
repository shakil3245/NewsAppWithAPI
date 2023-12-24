
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Controller/authController.dart';
import '../homePage.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthCheckController _authCheckController = AuthCheckController();
  bool _isloading = false;

  //THIS FUCKTION WILL HELP TO LOGIN USER
  _LoginUsers() async {

    if (_globalKey.currentState!.validate()) {
      String res = await _authCheckController.LoginUser(
          _emailController.text, _passwordController.text);
      if (res == 'success') {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage()));
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('something went wrong!')));
      }
    }
    else {
      setState(() {
        _isloading = false;
      });
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please filed must not be empty!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Form(
            key: _globalKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.1,),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                      child: Image.asset('assets/news_app.png')),
                  Text(
                    "Login User ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      } else {
                        return null;
                      }
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Email',
                      labelText: 'Enter Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter Password',
                      labelText: 'Enter Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: _isloading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal),
                          onPressed: () {
                            _LoginUsers();
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 20, color: Colors.white),
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't Have An Account? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                          child: const Text("Register"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}