import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class welcomeScreen extends StatefulWidget {

  static String id = 'welcome_screen';

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> with SingleTickerProviderStateMixin
{

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      //upperBound: 100
    );

    //animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.forward();
    controller.addListener(() {
      setState(() {});
      //print(controller.value); 
    });
  }

  @override
  Widget build(BuildContext context)   {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Text(
                      '💬 ',
                      style: TextStyle(
                        fontSize: 30,
                        //height: animation.value,
                      ),
                      ),
                  ),
                  Text(
                    "Let's Chat With Chat",
                    //'${controller.value.toInt()}%',// this will give us loading like value 0 to 100
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: AutofillHints.birthday,
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(350,45)
                ),
                onPressed: (){
                  Navigator.pushNamed(context,loginScreen.id);
                },
                child: const Text('Login')
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(350,45)
                ),
                onPressed: (){
                  Navigator.pushNamed(context,registrationScreen.id);
                },
                child: const Text('Registration')
              )
            ],
          ),
        )
        ),
    );
  }
}