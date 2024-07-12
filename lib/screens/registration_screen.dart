import 'package:chat/constants.dart';
import 'package:chat/screens/chat_screen.dart';
//  import 'package:chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class registrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  const registrationScreen({super.key});

  @override
  State<registrationScreen> createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {

  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  late String Email;
  late String Passward;
  late String ConfirmPassward;
  final _EmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ConfirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
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
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _EmailController,
                      // onChanged: (value){
                      //   Email = value;
                      // },
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Enter Email';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: kTextFildDecoration('Email'),
                    )
                  ),
                ),
                
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      // onChanged: (value){
                      //   Passward = value;
                      // },
                      validator: (value) {
                        if(value == null || value.length < 8){
                          return 'Enter Password';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: kTextFildDecoration('Password'),
                    )
                    ),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      controller: _ConfirmPasswordController,
                      // onChanged: (value){
                      //   ConfirmPassward = value;
                      // },
                      validator: (value) {
                        if(value == null || value != _passwordController.text){
                          return "Password don't match";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: kTextFildDecoration('Confirm Password'),
                    )
                    ),
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
                      final newUser = await _auth.createUserWithEmailAndPassword(email: _EmailController.text, password: _passwordController.text);
                      
                      // ignore: unnecessary_null_comparison
                      if(newUser != null){
                      Navigator.pushNamed(context,chatScreen.id);

                      setState(() {
                        showSpinner = false;
                      });
                    }
                  
                    }
                    catch(e){
                      setState(() {
                        showSpinner = false;
                      });
                      print(e);
                    }
        
                    // print(PhoneNo);
                    // print(Passward);
                    // print(ConfirmPassward);
                  },
                  child: const Text('Register')
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}