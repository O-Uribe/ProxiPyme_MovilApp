import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:proxi_pyme/pages/categories_page.dart';
import 'package:proxi_pyme/pages/home_page.dart';
import 'package:proxi_pyme/pages/login_page.dart';
import 'package:proxi_pyme/pages/register_page.dart';
import 'package:proxi_pyme/pages/main_page.dart';
import 'package:proxi_pyme/pages/settings_page.dart';
import 'package:proxi_pyme/pages/map_page.dart';
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

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProxiPyme',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: (token == null || JwtDecoder.isExpired(token) == true)
          ? MainPage()
          : HomePage(token: token),

      // Rutas de la página
      initialRoute: '/',
      routes: {
        '/Index': (context) => HomePage(token: token),
        '/Login': (context) => LoginPage(),
        '/Register': (context) => RegisterPage(),
        '/Settings': (context) => SettingsPage(),
        '/Map': (context) => Map(),
        '/Categories': (context) => CategoriesPage()
      },
    );
  }
}
