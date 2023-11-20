import 'package:flutter/material.dart';
import 'package:proxi_pyme/components/logo_pymes.dart';
import 'package:proxi_pyme/components/text_field_container.dart';
import 'package:proxi_pyme/utils/constants.dart';
import 'package:proxi_pyme/utils/get_user.dart';

class UserProfile extends StatefulWidget {
  final String nombrePyme;

  const UserProfile({Key? key, required this.nombrePyme}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Map<String, dynamic> userData = {};
  late Future<void> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = fetchUserData();
  }

  Future<void> fetchUserData() async {
    return await UserService.fetchUsers().then((jsonData) {
      if (jsonData != null) {
        for (var usuario in jsonData) {
          if (usuario['nombrePyme'] == widget.nombrePyme) {
            setState(() {
              userData = usuario;
            });
            break; // Detener el bucle una vez que se encuentre la coincidencia
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userData['nombrePyme'] ?? '',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              // Widget de carga animada (puedes usar CircularProgressIndicator, etc.)
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              // Manejo de errores si la carga falla
              child: Text('Error al cargar los datos'),
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: IconoLogo(
                      logoUrl: userData['logoPyme'] ?? '',
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Descripción",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Align(
                      alignment: Alignment.center,
                      child: TextFieldContainer(
                        alignment: TextContainerAlignment.center,
                        vertical: 10.0,
                        child: Text(
                          userData['descripcionPyme'] ?? '',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )),
                  const SizedBox(height: 20.0),
                  Text(
                    'Contacto',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  // Usando un TextFieldContainer para los siguientes datos
                  TextFieldContainer(
                    vertical: 15.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Correo : ${userData['correo'] ?? ''}',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          'Encargado: ${userData['encargadoPyme'] ?? ''}',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          'Categoría: ${userData['categoriaPyme'] ?? ''}',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Ubicación',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5.0),

                  Container(
                    color: Colors.grey[300],
                    constraints: BoxConstraints(
                      maxHeight: 100.0,
                      maxWidth: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text("Productos:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      )),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
