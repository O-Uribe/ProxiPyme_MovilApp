import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:proxi_pyme/pages/home_page.dart';
// import 'package:proxi_pyme/pages/index.dart';
import 'package:proxi_pyme/pages/login_page.dart';
import 'package:proxi_pyme/pages/register_page.dart';
import 'package:proxi_pyme/pages/main_page.dart';
import 'package:proxi_pyme/pages/image_upload_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    token: prefs.getString('token'),
  ));
}

class MyApp extends StatelessWidget {
  final dynamic token;
  const MyApp({this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
      home: (token == null || JwtDecoder.isExpired(token) == true)
          ? MainPage()
          // : IndexPage(token: token),
          : HomePage(token: token),

      // Rutas de la página
      initialRoute: '/',
      routes: {
        '/Index': (context) => HomePage(token: token),
        '/Login': (context) => LoginPage(),
        '/Register': (context) => RegisterPage(),
        '/UploadImage': (context) => ImageUploadPage()
      },
    );
  }
}
