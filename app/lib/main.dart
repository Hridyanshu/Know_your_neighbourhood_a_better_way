import 'package:flutter/material.dart';
import 'package:knowyourneighbourapp/screens/welcome_screen.dart';
import 'package:knowyourneighbourapp/screens/login_screen.dart';
import 'package:knowyourneighbourapp/screens/registration_screen.dart';
import 'package:knowyourneighbourapp/screens/chat_screen.dart';

void main() => runApp(NowChat());

class NowChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: WelcomeScreen.id,
      routes:{
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        ChatScreen.id:(context)=>ChatScreen(),
      },
    );
  }
}
