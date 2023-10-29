import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Variables para subir imagen y obtener Dirección
  final picker = ImagePicker();
  String userType = 'Cliente', imageUrl = '', latitud = '', longitud = '';
  File? _image;
  bool showPymeForm = false;

  // Campos para usuario Cliente
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Campos adicionales para usuario Pyme
  TextEditingController pymeNameController = TextEditingController();
  TextEditingController pymeAddressController = TextEditingController();
  TextEditingController pymeManagerController = TextEditingController();
  TextEditingController pymeDescriptionController = TextEditingController();

  Future<void> registerUser(String username, email, password, userType,
      {String? pymeName,
      pymeAddress,
      pymeManager,
      pymeDescription,
      logoPath}) async {
    //final url = Uri.parse('http://192.168.1.187:5000/api/users/register');
    //final url = Uri.parse('http://192.168.0.129:5000/api/users/register');
    final url = Uri.parse(
        'https://proxipymemovilapp-production.up.railway.app/api/users/register');

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
        'logoPyme': logoPath,
      }),
    );

    if (response.statusCode == 201) {
      print('Registro exitoso');
    } else {
      print('Registro fallido');
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://proxipymemovilapp-production.up.railway.app/upload'),
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      request.files
          .add(await http.MultipartFile.fromPath('image', _image!.path));
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          var responseBody = json.decode(await response.stream.bytesToString());
          imageUrl = responseBody["data"]["url"];
        }
      } catch (e) {
        print('Error al subir la imagen: $e');
      }
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
                obscureText: true,
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
              direccion(),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Seleccionar Logo'),
              ),
              _image == null
                  ? Text('Selecciona una imagen')
                  : Image.file(
                      _image!,
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.contain,
                    ),
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
                if (userType == 'Pyme') {
                  pymeName = pymeNameController.text;
                  //pymeAddress = pymeAddressController.text;
                  pymeAddress = '$latitud,$longitud';
                  pymeManager = pymeManagerController.text;
                  pymeDescription = pymeDescriptionController.text;
                }
                registerUser(username, email, password, userType,
                    pymeName: pymeName,
                    pymeAddress: pymeAddress,
                    pymeManager: pymeManager,
                    pymeDescription: pymeDescription,
                    logoPath: imageUrl);

                Navigator.pop(context);
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

  direccion() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: pymeAddressController,
        googleAPIKey: "AIzaSyC4l_K_-n3awrdP66-77DHDbKfc6SpKxP8",
        inputDecoration: InputDecoration(
          hintText: "Indica la dirección de tu Pyme",
          border: InputBorder.none,
        ),
        debounceTime: 400,
        countries: ["CL"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) async {
          latitud = prediction.lat!;
          longitud = prediction.lng!;
        },
        itemClick: (Prediction prediction) {
          pymeAddressController.text = prediction.description ?? "";
          pymeAddressController.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
        },
        isCrossBtnShown: true,
      ),
    );
  }
}
