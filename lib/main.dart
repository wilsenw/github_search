import 'package:flutter/material.dart';
import 'navbar.dart';
import 'shared/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _theme(),
      home: const NavBar(),
    );
  }

  ThemeData _theme() {
    return ThemeData(
      //apply style untuk masing - masing text
      fontFamily: 'Montserrat',
      textTheme: const TextTheme(
        headlineMedium: title1TextStyle, //size besar, hitam
        bodyLarge: body1TextStyle, //size medium, hitam
        bodyMedium: body2TextStyle, //size kecil, hitam
        bodySmall: body3TextStyle, //size paling kecil, hitam
      ),
    );
  }
}
