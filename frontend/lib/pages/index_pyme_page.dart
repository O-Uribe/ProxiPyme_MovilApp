import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:proxi_pyme/utils/get_user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class IndexPymePage extends StatefulWidget {
  final dynamic token;
  const IndexPymePage({@required this.token, Key? key}) : super(key: key);

  @override
  State<IndexPymePage> createState() => _IndexPymePageState();
}

class _IndexPymePageState extends State<IndexPymePage> {
  late String userId;

  Map<String, dynamic>? userData;
  String searchQuery = "";
  List<String> searchResults = [];

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? jwtDecodedToken = JwtDecoder.decode(widget.token);

    userId = jwtDecodedToken['userId'];

    fetchUser(userId);

    searchController.addListener(() {
      searchUsers(searchController.text);
    });
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
    final response = await http.get(Uri.parse('https://proxipymemovilapp-production.up.railway.app/api/users/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  void searchUsers(String query) async {
    List<dynamic> users = await fetchUsers();
    setState(() {
      searchQuery = query;
      searchResults = users
      .where((user) => user['tipoUsuario'] == 'Pyme' && user['nombreUsuario'].contains(query))
      .map((user) => user['nombreUsuario'] as String) // Cast each user's name to String
      .toList();
    });
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
                Text("Categorías",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    )),
                Text("Ver más",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    )),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          SizedBox(
              height: 190.0,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 2,
                ),
                children: <Widget>[
                  _gridItem(Icon(Icons.restaurant, color: Colors.white),
                      Color.fromRGBO(199, 220, 167, 1.0), "Comida"),
                  _gridItem(Icon(Icons.local_cafe, color: Colors.white),
                      Color.fromRGBO(199, 220, 167, 1.0), "Cafés"),
                  _gridItem(Icon(Icons.shopping_bag, color: Colors.white),
                      Color.fromRGBO(199, 220, 167, 1.0), "Ropa"),
                  _gridItem(Icon(Icons.home, color: Colors.white),
                      Color.fromRGBO(199, 220, 167, 1.0), "Decoración"),
                  _gridItem(Icon(Icons.card_giftcard, color: Colors.white),
                      Color.fromRGBO(199, 220, 167, 1.0), "Regalos"),
                  _gridItem(Icon(Icons.palette, color: Colors.white),
                      Color.fromRGBO(199, 220, 167, 1.0), "Artesanías"),
                  _gridItem(Icon(Icons.phone_android, color: Colors.white),
                      Color.fromRGBO(199, 220, 167, 1.0), "Electrónica"),
                  _gridItem(Icon(Icons.book, color: Colors.white),
                      Color.fromRGBO(199, 220, 167, 1.0), "Libros"),
                  _gridItem(Icon(Icons.music_note, color: Colors.white),
                      Color.fromRGBO(199, 220, 167, 1.0), "Música"),
                  _gridItem(Icon(Icons.edit, color: Colors.white),
                      Color.fromRGBO(199, 220, 167, 1.0), "Papelería"),
                ],
              )),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text("Últimas publicaciones",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    )),
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

_gridItem(Icon icon, Color color, String label) {
  return Card(
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon,
        SizedBox(height: 10.0),
        Text(label,
            style: TextStyle(
              color: Colors.white,
            )),
      ],
    ),
  );
}

_top(Map<String, dynamic>? userData) {
  return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 26, 101, 158),
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
                    child: IconoLogo(logoUrl: userData?["logoPyme"]),
                  ),
                  SizedBox(width: 10.0),
                  Text("Hola, ${userData?["encargadoPyme"]}",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: const Color.fromARGB(255, 18, 184, 148),
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 15.0),
          TextField(
            controller: searchController.text,
            decoration: InputDecoration(
              hintText: "Buscar",
              fillColor: Colors.white,
              filled: true,
              suffixIcon: Icon(Icons.filter_list,
                  color: const Color.fromRGBO(0, 150, 136, 1)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            ),
          ),
        ],
      ));
}

class IconoLogo extends StatelessWidget {
  final String? logoUrl;

  const IconoLogo({Key? key, this.logoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.teal,
        ),
      ),
      child: logoUrl != null
          ? ClipOval(
              child: Image.network(
                logoUrl!,
                width: 50,
                height: 50,
                fit: BoxFit.cover, // Ajusta la imagen dentro del círculo
              ),
            )
          : ClipOval(
              child: Image.asset(
                'assets/images/perfil.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
