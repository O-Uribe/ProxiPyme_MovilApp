import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proxi_pyme/components/check_account.dart';
import 'package:proxi_pyme/components/custom_drop_button.dart';
import 'package:proxi_pyme/components/rounded_button.dart';
import 'package:proxi_pyme/components/rounded_input_field.dart';
import 'package:proxi_pyme/components/rounded_password_field.dart';
import 'package:proxi_pyme/components/text_field_container.dart';
import 'package:proxi_pyme/pages/login/login_page.dart';
import 'package:proxi_pyme/pages/register/components/background.dart';
import 'package:proxi_pyme/utils/constants.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final picker = ImagePicker();
  late String userType = 'Cliente',
      imageUrl = '',
      latitud = '',
      longitud = '',
      googleApiKey = dotenv.env['GOOGLE_API_KEY'] ?? '';
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
    await dotenv.load(fileName: '.env');

    final url = Uri.parse(dotenv.env['URL_REGISTER'] ?? '');

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

  void badRegister() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('No se pudo registrar el usuario'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Únete a ProxiPyme!!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.1,
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "¿Cómo quieres registrarte?",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              CustomDropdownButton(
                value: userType,
                onChanged: (String? newValue) {
                  setState(() {
                    userType = newValue ?? 'Cliente';
                    showPymeForm = newValue == 'Pyme';
                  });
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                controller: usernameController,
                hintText: "Nombre de usuario",
                onChanged: (value) {},
              ),
              RoundedInputField(
                controller: emailController,
                icon: Icons.email,
                hintText: "Correo electrónico",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                  controller: passwordController, onChanged: (value) {}),
              SizedBox(height: size.height * 0.03),
              Text('Registra los datos de tu Pyme',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              if (showPymeForm) ...[
                RoundedInputField(
                  controller: pymeNameController,
                  icon: Icons.store,
                  hintText: "Nombre de tu Pyme",
                  onChanged: (value) {},
                ),
                direccion(),
                RoundedInputField(
                  controller: pymeManagerController,
                  icon: Icons.supervisor_account,
                  hintText: "Tu Primer Nombre",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  controller: pymeDescriptionController,
                  icon: Icons.description,
                  hintText: "Categoria de tu Pyme",
                  onChanged: (value) {},
                ),
                logo(),
              ],
              RoundedButton(
                  text: "Registrarse",
                  press: () {
                    final username = usernameController.text;
                    final email = emailController.text;
                    final password = passwordController.text;
                    String? pymeName;
                    String? pymeAddress;
                    String? pymeManager;
                    String? pymeDescription;
                    if (userType == 'Pyme') {
                      pymeName = pymeNameController.text;
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
                  }),
              SizedBox(height: size.height * 0.03),
              CheckAccount(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget direccion() {
    return TextFieldContainer(
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: pymeAddressController,
        googleAPIKey: googleApiKey,
        inputDecoration: InputDecoration(
          hintText: "Dirección de tu Pyme",
          icon: Icon(
            Icons.location_on,
            color: kPrimaryColor,
          ),
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

  Widget logo() {
    return TextFieldContainer(
      child: Column(
        children: [
          if (_image != null) ...[
            Image.file(
              _image!,
              height: 100,
            ),
          ],
          RoundedButton(text: 'Sube tu logo', press: _uploadImage),
        ],
      ),
    );
  }
}
