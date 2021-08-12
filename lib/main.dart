import 'package:flutter/material.dart';
import 'package:stripe_payment_flutter_app/screens/cards.dart';
import 'package:stripe_payment_flutter_app/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STRIPE CHECKOUT', //app title
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //initial route
      initialRoute: '/home',
      routes: {
          //home and existing cards routes
        '/home': (context) => HomeScreen(),
        '/existing-cards': (context) => ExistingCardsScreen()
      },
    );
  }
}