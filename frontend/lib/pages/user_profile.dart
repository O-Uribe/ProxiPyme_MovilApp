import 'package:flutter/material.dart';
//import 'package:proxi_pyme/pages/index_pyme_page.dart';
import 'package:proxi_pyme/pages/index_user_page.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/ñandrejo.png'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),

              // **User information section**
              Text(
                'Juan Pérez',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'juan.perez@example.com',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ac lorem enim. Vivamus semper, sem eget tincidunt scelerisque, lectus lectus scelerisque felis, ac tincidunt velit enim quis neque. Nullam scelerisque quam sit amet urna scelerisque, eget scelerisque ipsum faucibus. Sed eu eros tristique, iaculis velit in, tristique nisl. Fusce ultricies, lectus vel consequat tristique, quam mauris semper diam, ac feugiat mauris nulla id sapien.',
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32.0),

              // **Quick actions section**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomImageButton(
                    imageAsset: 'assets/images/mapa.png',
                    label: 'Ubicación',
                    onTap: () {
                      Navigator.pushNamed(context, '/Map');
                    },
                  ),
                  CustomImageButton(
                    imageAsset: 'assets/images/ñandrejo.png',
                    label: 'Productos',
                    onTap: () {
                      Navigator.pushNamed(context, '/Categories');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32.0),

              // **Comments section**
              Text(
                'Reseñas',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // **Comment input field**
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Añadir un comentario',
                      ),
                    ),
                  ),

                  // **Submit comment button**
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.send),
                  ),
                ],
              ),

              // **List of comments**
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage('assets/images/ñandrejo.png'),
                    ),
                    title: Text('Juan Pérez'),
                    subtitle: Text('Este es un comentario'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
