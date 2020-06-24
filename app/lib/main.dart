import 'package:flutter/material.dart';
import 'package:knowyourneighbourapp/screens/welcome_screen.dart';
import 'package:knowyourneighbourapp/screens/login_screen.dart';
import 'package:knowyourneighbourapp/screens/registration_screen.dart';
import 'package:knowyourneighbourapp/screens/chat_screen.dart';
import 'screens/LocationScreen.dart';

void main() => runApp(NowChat());

class NowChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: WelcomeScreen.id,
      routes:{
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        LocationScreen.id:(context)=>LocationScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        ChatScreen.id:(context)=>ChatScreen(),
      },
    );
  }
}