import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:proxi_pyme/pages/categories_page.dart';
import 'package:proxi_pyme/pages/home_page.dart';
import 'package:proxi_pyme/pages/login/login_page.dart';
import 'package:proxi_pyme/pages/register/register_page.dart';
import 'package:proxi_pyme/pages/welcome/main_page.dart';
import 'package:proxi_pyme/pages/settings_page.dart';
import 'package:proxi_pyme/pages/map_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");
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
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        // Función para cargar datos
        future: _loadData(), 

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error cargando los datos'),
              );
            } else {
              return (token == null || JwtDecoder.isExpired(token) == true)
                  ? MainPage()
                  : HomePage(token: token);
            }
          } else {

            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

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

// Los datos estarán cargando por 3 segundos
Future<void> _loadData() async {
  await Future.delayed(Duration(seconds: 3));
}
