// ignore_for_file: camel_case_types

import 'package:chat/constants.dart';
import 'package:chat/screens/chat_screen.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class loginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  late String Email;
  late String Password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Text(
                      '💬',
                      style: TextStyle(
                        fontSize: 100
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value){
                      Email = value;
                    },
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: kTextFildDecoration(' Email'),
                  )
                ),
                
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (value){
                      Password = value;
                    },
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: kTextFildDecoration('Password'),
                  )
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    fixedSize: const Size(350,45)
                  ),
                  onPressed: () async{

                    setState(() {
                      showSpinner = true;
                    });
        
                    try{
                      final user = await _auth.signInWithEmailAndPassword(email: Email, password: Password);
                      // ignore: unnecessary_null_comparison
                      if(user != null){
                        Navigator.pushNamed(context,chatScreen.id);
                      }

                      setState(() {
                        showSpinner = false;
                      });

                    }
                    catch(e){

                      setState(() {
                        showSpinner = false;
                      });
                      print(e);
                    }
                    
                    print(Email);
                    print(Password);
                  },
                  child: const Text('Login')
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}