import 'package:flutter/material.dart';
// import 'package:proxi_pyme/pages/home_page.dart';
import 'package:proxi_pyme/pages/image_upload_page.dart';
import 'package:proxi_pyme/pages/index.dart';
import 'package:proxi_pyme/pages/map.dart';
import 'package:proxi_pyme/pages/p2.dart';

class RoutesNavBar extends StatelessWidget {
  final int index;
  final dynamic token;
  const RoutesNavBar({super.key, required this.index, this.token});

  @override
  Widget build(BuildContext context) {
    // Páginas que serán mostradas en el BottomNavigationBar
    List<Widget> listaPaginas = [
      // HomePage(token: token),
      IndexPage(token: token),
      Map(),
      Page2(),
      ImageUploadPage()
    ];

    return listaPaginas[index];
  }
}