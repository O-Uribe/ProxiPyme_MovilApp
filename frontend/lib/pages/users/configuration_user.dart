import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';

class ConfigurationUserPage extends StatefulWidget {
  const ConfigurationUserPage({Key? key}) : super(key: key);

  @override
  State<ConfigurationUserPage> createState() => _ConfigurationUserPageState();
}

class _ConfigurationUserPageState extends State<ConfigurationUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Nombre
          _configurationItem(
            title: 'Nombre',
            value: 'XD',
            onTap: () => _showEditDialog('Nombre'),
          ),
          // Correo
          _configurationItem(
            title: 'Correo electrónico',
            value: 'XD@gmail.com',
            onTap: () => _showEditDialog('Correo electrónico'),
          ),
          // Contraseña
          _configurationItem(
            title: 'Contraseña',
            value: '123456',
            onTap: () => _showEditDialog('Contraseña'),
          ),
          // Foto
          _configurationItem(
            title: 'Foto',
            value: 'assets/images/perfil.png',
            onTap: () => _showEditDialog('Foto'),
          ),
          // Botón de cerrar sesión
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: () {
                // Cerrar sesión
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Cerrar sesión'),
            ),
          ),
        ],
      ),
    );
  }

void _showEditDialog(String title) {
    showDialog(
      context: context,
      builder: (context) {
        switch (title) {
          case 'Nombre':
            return _editNameDialog();
          case 'Correo electrónico':
            return _editEmailDialog();
          case 'Contraseña':
            return _editPasswordDialog();
          case 'Foto':
            return _editPhotoDialog();
          default:
            return AlertDialog(
              title: Text('Editar $title'),
              content: Text('Función no implementada'),
              actions: [
                TextButton(
                   child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            );
        }
      },
    );
  }

  AlertDialog _editNameDialog() {
    return AlertDialog(
      title: Text('Editar nombre'),
      content: TextField(
        decoration: InputDecoration(
          hintText: 'Nuevo nombre',
        ),
      ),
      actions: [
        TextButton(
          child: Text('Guardar'),
          onPressed: () {
            // Validar que el nombre no esté vacío
            // y guardar el nuevo nombre en la base de datos
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  AlertDialog _editEmailDialog() {
    return AlertDialog(
      title: Text('Editar correo electrónico'),
      content: TextField(
        decoration: InputDecoration(
          hintText: 'Nuevo correo electrónico',
        ),
      ),
      actions: [
        TextButton(
          child: Text('Guardar'),
          onPressed: () {
            // Validar que el correo electrónico sea válido
            // y guardarlo en la base de datos
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

 AlertDialog _editPasswordDialog() {
  return AlertDialog(
    title: Text('Editar contraseña'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Contraseña actual',
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: 'Nueva contraseña',
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: 'Confirmar contraseña',
          ),
          obscureText: true,
        ),
      ],
    ),
    actions: [
      TextButton(
        child: Text('Guardar'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Text('Cancelar'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}


  AlertDialog _editPhotoDialog() {
  return AlertDialog(
    title: Text('Editar foto'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Selecciona una nueva foto',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () {
                // Abrir la galería para seleccionar una foto
              },
            ),
          ],
        ),
        // Imagen de la foto actual
        Image.asset(
          'assets/images/perfil.png',
          width: 100,
          height: 100,
        ),
      ],
    ),
    actions: [
      TextButton(
        child: Text('Guardar'),
        onPressed: () {
          // Guardar la nueva foto en la base de datos
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Text('Cancelar'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}


  Widget _configurationItem({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: onTap,
        ),
      ),
    );
  }
}
