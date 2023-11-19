import 'package:flutter/material.dart';
import 'package:proxi_pyme/pages/Pymes/user_profile.dart';
import 'package:proxi_pyme/utils/constants.dart';
import 'package:proxi_pyme/utils/get_user.dart';

class CategoriesPage extends StatefulWidget {
  final String categoria;

  const CategoriesPage({Key? key, required this.categoria}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<dynamic> pymes = []; // Lista de pymes para la categoría seleccionada

  @override
  void initState() {
    super.initState();
    fetchPymes(); // Obtener las pymes al iniciar la página
  }

  Future<void> fetchPymes() async {
    List<dynamic> tempList = [];

    // Lógica para obtener las pymes de la categoría seleccionada
    await UserService.fetchUsers().then((jsonData) {
      if (jsonData != null) {
        for (var user in jsonData) {
          var nombrePyme = user['nombrePyme'];
          if (nombrePyme != null && user['categoriaPyme'] == widget.categoria) {
            tempList.add(nombrePyme);
          }
        }
      }
    });

    setState(() {
      pymes = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pymes de ${widget.categoria}'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: ListView.builder(
        itemCount: pymes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navegar a la página de la pyme con el nombre correspondiente
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(),
                ),
              );
            },
            child: box_pyme(pymes[index]),
          );
        },
      ),
    );
  }

  Widget box_pyme(String nombrePyme) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                nombrePyme,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
