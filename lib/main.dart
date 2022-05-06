//============ Aplikasi Searching Github ================
//============ Dibuat oleh: Wilsen Widjaja ================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navbar.dart';
import 'shared/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(theme: theme(), home: const NavBar());
  }

  //============ Theme untuk keseluruhan aplikasi ================
  ThemeData theme() {
    return ThemeData(
      //apply style untuk warna
      primaryColor: Colors.greenAccent,
      backgroundColor: Colors.grey[100],
      //apply style untuk font
      fontFamily: 'Montserrat',
      //apply style untuk text
      textTheme: const TextTheme(
        headlineMedium: title1TextStyle, //size besar, hitam
        bodyLarge: body1TextStyle, //size medium, hitam
        bodyMedium: body2TextStyle, //size kecil, hitam
        bodySmall: body3TextStyle, //size paling kecil, hitam
      ),
    );
  }
}
