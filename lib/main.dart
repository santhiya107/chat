
import 'package:chatapp/screens/splash_screen.dart';
import 'package:chatapp/screens/auth_screen.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Future<FirebaseApp> initialization = Firebase.initializeApp();
    return FutureBuilder(
      // Initialize FlutterFire:
        future: initialization,
        builder: (context, appSnapshot) {


          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'FlutterChat',
            theme: ThemeData(
              primarySwatch: Colors.blue,



            ),
            home: appSnapshot.connectionState != ConnectionState.done ? SplashScreen() : StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              }
              if (userSnapshot.hasData) {
                return ChatScreen();
              }
              return AuthScreen();
            }),
          );

        });

  }
}