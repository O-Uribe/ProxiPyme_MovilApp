import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String userType = 'Cliente'; // Valor predeterminado: Cliente
  String? selectedImage; // Ruta de la imagen seleccionada

  // Campos adicionales para usuario Pyme
  TextEditingController pymeNameController = TextEditingController();
  TextEditingController pymeAddressController = TextEditingController();
  TextEditingController pymeManagerController = TextEditingController();
  TextEditingController pymeDescriptionController = TextEditingController();

  // Variable para controlar la visibilidad del formulario de pyme
  bool showPymeForm = false;

  Future<void> registerUser(
      String username, String email, String password, String userType,
      {String? pymeName,
      String? pymeAddress,
      String? pymeManager,
      String? pymeDescription,
      String? logoPath}) async {
    final url = Uri.parse('http://192.168.1.187:5000/api/users/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'nombreUsuario': username,
        'correo': email,
        'contraseña': password,
        'tipoUsuario': userType,
        'nombrePyme': pymeName,
        'direccionPyme': pymeAddress,
        'encargadoPyme': pymeManager,
        'descripcionPyme': pymeDescription,
        'logoPyme': logoPath, // Envía la ruta de la imagen como dato
      }),
    );

    if (response.statusCode == 201) {
      print('Registro exitoso');
    } else {
      print('Registro fallido');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text("Registrarse"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Ingrese sus datos",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nombre de usuario',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Correo electrónico',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Contraseña',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButton<String>(
              value: userType,
              onChanged: (value) {
                setState(() {
                  userType = value!;
                  // Mostrar u ocultar el formulario de pyme según la selección
                  showPymeForm = userType == 'Pyme';
                });
              },
              items: ['Cliente', 'Pyme'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            if (showPymeForm) ...[
              // Formulario adicional para usuario Pyme
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextFormField(
                  controller: pymeNameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nombre de la Pyme',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextFormField(
                  controller: pymeAddressController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Dirección de la Pyme',
                  ),
                ),
              ),
              // Botón para seleccionar una imagen
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Seleccionar Logo'),
              ),
              if (selectedImage !=
                  null) // Muestra la imagen seleccionada si hay una
                Image.file(File(selectedImage!), height: 100),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextFormField(
                  controller: pymeManagerController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nombre del Encargado',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextFormField(
                  controller: pymeDescriptionController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Descripción de la Pyme',
                  ),
                ),
              ),
            ],
            ElevatedButton(
              onPressed: () {
                final username = usernameController.text;
                final email = emailController.text;
                final password = passwordController.text;
                String? pymeName;
                String? pymeAddress;
                String? pymeManager;
                String? pymeDescription;
                String? logoPath; // Ruta de la imagen seleccionada
                if (userType == 'Pyme') {
                  pymeName = pymeNameController.text;
                  pymeAddress = pymeAddressController.text;
                  pymeManager = pymeManagerController.text;
                  pymeDescription = pymeDescriptionController.text;
                  logoPath = selectedImage; // Asigna la ruta de la imagen
                }
                registerUser(username, email, password, userType,
                    pymeName: pymeName,
                    pymeAddress: pymeAddress,
                    pymeManager: pymeManager,
                    pymeDescription: pymeDescription,
                    logoPath: logoPath); // Pasa la ruta de la imagen
              },
              style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
              child: Text(
                "Registrarse",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisterPage(),
  ));
}
