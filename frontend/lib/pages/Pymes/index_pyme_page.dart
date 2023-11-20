import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:proxi_pyme/components/logo_pymes.dart';
import 'package:proxi_pyme/utils/constants.dart';
import 'package:proxi_pyme/utils/get_user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class IndexPymePage extends StatefulWidget {
  final dynamic token;
  const IndexPymePage({@required this.token, Key? key}) : super(key: key);

  @override
  State<IndexPymePage> createState() => _IndexUserPageState();
}

class _IndexUserPageState extends State<IndexPymePage> {
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

  Future<void> _editPymeData() async {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productDescriptionController =
        TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar detalles de la PYME'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(labelText: 'Nombre del producto'),
              ),
              TextFormField(
                controller: productDescriptionController,
                decoration:
                    InputDecoration(labelText: 'Descripción del producto'),
              ),
              //campo para subir foto
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userData?['nombreProducto'] = productNameController.text;
                  userData?['descripcionProducto'] =
                      productDescriptionController.text;
                  // Actualiza otros campos según sea necesario
                });
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
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
                  "Sube tus productos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                IconButton(
                  onPressed: _editPymeData,
                  icon: Icon(Icons.add),
                ),
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
                    child: IconoLogo(
                      logoUrl: userData?["logoPyme"] ?? '',
                      width: 100.0,
                      height: 100.0,
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
