import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:proxi_pyme/pages/Pymes/categories_page.dart';
import 'package:proxi_pyme/utils/constants.dart';
import 'package:proxi_pyme/utils/get_user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class IndexUserPage extends StatefulWidget {
  final dynamic token;
  const IndexUserPage({@required this.token, Key? key}) : super(key: key);

  @override
  State<IndexUserPage> createState() => _IndexUserPageState();
}

class _IndexUserPageState extends State<IndexUserPage> {
  late String userId;

  Map<String, dynamic>? userData;
  String searchQuery = "";
  List<String> searchResults = [];

  bool showAllCategories = false;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? jwtDecodedToken = JwtDecoder.decode(widget.token);

    userId = jwtDecodedToken['userId'];

    fetchUser(userId);
  }

  Future<void> fetchUser(String userId) async {
    await UserService.fetchUsers().then((jsonData) {
      if (jsonData != null) {
        for (var usuario in jsonData) {
          if (usuario['_id'] == userId) {
            setState(() {
              userData = usuario;
            });
          }
        }
      }
    });
  }

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse(
        'https://proxipymemovilapp-production.up.railway.app/api/users/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<dynamic>> getUsers() async {
    List<dynamic> users = [];

    await UserService.fetchUsers().then((jsonData) {
      if (jsonData != null) {
        for (var user in jsonData) {
          var nombreUsuario = user['nombreUsuario'];
          if (nombreUsuario != null) {
            users.add(nombreUsuario);
          }
        }
      }
    });
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _top(userData),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Categorías",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      showAllCategories = !showAllCategories;
                    });
                  },
                  child: Text(
                    showAllCategories ? "Ver menos" : "Ver más",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: showAllCategories
                ? null
                : 190.0, // Si se muestra todo, no limites la altura
            child: GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3 / 2,
              ),
              children: <Widget>[
                _gridItem(context, Icon(Icons.restaurant, color: Colors.white),
                    Color.fromRGBO(199, 220, 167, 1.0), "Comida"),
                _gridItem(
                    context,
                    Icon(Icons.shopping_bag, color: Colors.white),
                    Color.fromRGBO(199, 220, 167, 1.0),
                    "Ropa"),
                _gridItem(context, Icon(Icons.woman, color: Colors.white),
                    Color.fromRGBO(199, 220, 167, 1.0), "Belleza"),
                _gridItem(
                    context,
                    Icon(Icons.medical_services, color: Colors.white),
                    Color.fromRGBO(199, 220, 167, 1.0),
                    "Salud"),
                _gridItem(context, Icon(Icons.home, color: Colors.white),
                    Color.fromRGBO(199, 220, 167, 1.0), "Hogar"),
                _gridItem(
                    context,
                    Icon(Icons.sports_soccer, color: Colors.white),
                    Color.fromRGBO(199, 220, 167, 1.0),
                    "Deportes"),
                _gridItem(context, Icon(Icons.pets, color: Colors.white),
                    Color.fromRGBO(199, 220, 167, 1.0), "Mascotas"),
                _gridItem(context, Icon(Icons.book, color: Colors.white),
                    Color.fromRGBO(199, 220, 167, 1.0), "Libros"),
                _gridItem(context, Icon(Icons.computer, color: Colors.white),
                    Color.fromRGBO(199, 220, 167, 1.0), "Tecnología"),
                _gridItem(context, Icon(Icons.local_offer, color: Colors.white),
                    Color.fromRGBO(199, 220, 167, 1.0), "Servicios"),
                _gridItem(context, Icon(Icons.more_horiz, color: Colors.white),
                    Color.fromRGBO(199, 220, 167, 1.0), "Otros"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  "Últimas publicaciones",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _cardItem(1),
          _cardItem(2),
        ],
      ),
    );
  }
}

_cardItem(image) {
  return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage("assets/images/locales.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Nombre del producto",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  )),
              SizedBox(height: 10.0),
              Text("Descripción de producto",
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 10.0),
              Text("publicador por",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )
        ],
      ));
}

Widget _gridItem(BuildContext context, Icon icon, Color color, String label) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoriesPage(categoria: label),
        ),
      );
    },
    child: Card(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          SizedBox(height: 10.0),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

_top(Map<String, dynamic>? userData) {
  return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/images/chitsu.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Hola, ${userData?["nombreUsuario"] ?? ''}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ));
}
