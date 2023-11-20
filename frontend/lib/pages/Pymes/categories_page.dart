import 'package:flutter/material.dart';
import 'package:proxi_pyme/components/logo_pymes.dart';
import 'package:proxi_pyme/pages/Pymes/user_profile.dart';
import 'package:proxi_pyme/utils/constants.dart';
import 'package:proxi_pyme/utils/get_user.dart';

class CategoriesPage extends StatefulWidget {
  final String categoria;

  const CategoriesPage({Key? key, required this.categoria}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late Future<List<dynamic>> _fetchPymesFuture;

  @override
  void initState() {
    super.initState();
    _fetchPymesFuture = fetchPymes();
  }

  Future<List<dynamic>> fetchPymes() async {
    List<dynamic> tempList = [];

    await UserService.fetchUsers().then((jsonData) {
      if (jsonData != null) {
        for (var user in jsonData) {
          var nombrePyme = user['nombrePyme'];
          var logoPyme = user['logoPyme'];

          if (nombrePyme != null &&
              logoPyme != null &&
              user['categoriaPyme'] == widget.categoria) {
            tempList.add({
              'nombrePyme': nombrePyme,
              'logoPyme': logoPyme,
            });
          }
        }
      }
    });

    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pymes de ${widget.categoria}'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder(
        future: _fetchPymesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los datos'),
            );
          } else {
            List<dynamic> pymes = snapshot.data as List<dynamic>;
            return GridView.builder(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
              ),
              itemCount: pymes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserProfile(nombrePyme: pymes[index]['nombrePyme']),
                      ),
                    );
                  },
                  child: box_pyme(
                      pymes[index]['nombrePyme'], pymes[index]['logoPyme']),
                );
              },
            );
          }
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget box_pyme(String nombrePyme, String logoUrl) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(60),
            ),
            child: IconoLogo(
              logoUrl: logoUrl,
            ),
          ),
          SizedBox(height: 10),
          Text(
            nombrePyme,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
