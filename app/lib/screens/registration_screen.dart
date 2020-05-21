import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowyourneighbourapp/components/rounded_button.dart';
import 'package:knowyourneighbourapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knowyourneighbourapp/screens/login_screen.dart';
import 'package:knowyourneighbourapp/screens/welcome_screen.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id='registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
//              Flexible(
//                child: Hero(
//                  tag: 'logo',
//                  child: Container(
//                    height: 200.0,
//                    child: Image.asset('images/logo.png'),
//                  ),
//                ),
//              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email')
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
                decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your password')
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
              title: 'Register',
              colour: Colors.blueAccent,
              onPressed: ()async{
                setState(() {
                  showSpinner=true;
                });
               try {
                 final newUser = await _auth.createUserWithEmailAndPassword(
                     email: email.trim(), password: password);
                 if(newUser!=null){
                   var user = await _auth.currentUser();
                   await user.sendEmailVerification();
                   Alert(
                     context: context,
                     type: AlertType.success,
                     title: "Sign Up Alert",
                     desc: "Verify Your Email Address",
                     buttons: [
                       DialogButton(
                         child: Text(
                           "Cancel",
                           style: TextStyle(color: Colors.white, fontSize: 20),
                         ),
                         onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
                         width: 120,
                       )
                     ],
                   ).show();
                 }
                 showSpinner=false;
               }
              catch(e){
                showSpinner=false;
                Alert(
                  context: context,
                  type: AlertType.error,
                  title: "Try Again",
                  desc: 'This account is already registered with us.',
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pushNamed(context,RegistrationScreen.id),
                      width: 120,
                    )
                  ],
                ).show();

              }
              })
            ],
          ),
        ),
      ),
    );
  }
}


