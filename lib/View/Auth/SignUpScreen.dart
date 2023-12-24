import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import '../widgets/textFormFild.dart';
import 'loginScreen.dart';

class RegistrationScreen extends StatefulWidget {



  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  File? imageFile;
  bool _isLoading = false;
  // final FirebaseAuth _auth = FirebaseAuth.instance;


  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  // THIS FUCKTION WILL SEND THE DATA TO FIREBASE FIRESTORE

  _submitFormForSignUp() async {
    final isValid = _signUpFormKey.currentState!.validate();
    if(isValid){
      try {
        // create user account with createUserWithEmailAndPassword
        final credential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );

        // upload data to cloude firestore
        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
            {
              'id': FirebaseAuth.instance.currentUser!.uid,
              'name': _nameController.text, // John Doe// Stokes and Sons
              'email': _emailController.text,
              'password': _passwordController.text,
              'phoneNumber': _phoneController.text,
              'location': _addressNameController.text,
              'createdAt': Timestamp.now(),
            }

        );
        Navigator.canPop(context)? Navigator.pop(context):null;
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _phoneController.clear();
        _addressNameController.clear();


      } catch (e) {
        log(e.toString());
        setState(() {
          _isLoading = false;
        });
      }
      setState(() {
        _signUpFormKey.currentState!.reset();
      });
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content: Text("Successfully Created!")));
    }else{
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text("Please fill all the Requirments!")));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _signUpFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Center(
                      child: Text(
                        "Create User Account",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                      )),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormFilds(nameController: _nameController, validateString: "Please Enter Name", hinTextString: 'Enter Full Name', lebelTextString: 'Enter Full name',),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFilds(nameController: _phoneController, validateString: "Please Enter Phone Number", hinTextString:  'Enter Phone Number', lebelTextString:  'Enter Phone Number'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFilds(nameController:_addressNameController, validateString: "Please Enter Address", hinTextString: "Please Enter Address", lebelTextString: "Please Enter Address"),

                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFilds(nameController: _emailController, validateString: "Please Enter Email", hinTextString: "Please Enter Email", lebelTextString: "Please Enter Email"),

                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFilds(nameController: _passwordController, validateString: "Please Enter Password", hinTextString: "Please Enter Password", lebelTextString: "Please Enter Password"),

                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: _isLoading?Center(child: SpinKitCircle(
                      size: 50,
                      color: Colors.green,
                    ),): SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal),
                            onPressed: () {
                              _submitFormForSignUp();
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ))),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Have An Account? "),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      }, child: const Text("Login"))
                    ],)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

