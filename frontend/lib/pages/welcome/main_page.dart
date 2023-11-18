import 'package:flutter/material.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:proxi_pyme/pages/welcome/components/body.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  void configurarCloudinary() {
    CloudinaryContext.cloudinary =
        Cloudinary.fromCloudName(cloudName: "drjqvi7mx");
  }

  @override
  Widget build(BuildContext context) {
    configurarCloudinary();

    return Scaffold(
      body: Body(),
    );
  }
}
