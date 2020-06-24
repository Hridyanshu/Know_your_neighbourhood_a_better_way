// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:knowyourneighbourapp/components/rounded_button.dart';
import 'package:knowyourneighbourapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knowyourneighbourapp/screens/LocationScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class LoginScreen extends StatefulWidget {
  static const String id='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  String email,password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email.')
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password.')
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
              title: 'Login',
              colour: Colors.lightBlueAccent,
              onPressed: ()async{
                setState(() {
                  showSpinner=true;
                });
                try {
                  final newUser = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
                  if(newUser!=null){
                    var user = await _auth.currentUser();
                    if (user.isEmailVerified) {
                      Navigator.pushNamed(context, LocationScreen.id);
                    }
                    else {
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Verification Required",
                        desc: "Please Verify Your Email and Try Again.",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pushNamed(context,LoginScreen.id),
                             width: 120,
                          )
                        ],
                      ).show();
                    }
                  }
                  setState(() {
                    showSpinner=false;
                  });
                }
                catch(e){
                  Alert(
                    context: context,
                    type: AlertType.error,
                    title: "$e",
//                    desc: "$e",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pushNamed(context,LoginScreen.id),
                        width: 120,
                      )
                    ],
                  ).show();

                }
              },)
            ],
          ),
        ),
      ),
    );
  }
}
