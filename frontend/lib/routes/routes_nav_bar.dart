import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:proxi_pyme/pages/settings_page.dart';
import 'package:proxi_pyme/pages/map_page.dart';
import 'package:proxi_pyme/pages/activity_page.dart';
import 'package:proxi_pyme/pages/Pymes/index_pyme_page.dart';
import 'package:proxi_pyme/pages/users/index_user_page.dart';
import 'package:proxi_pyme/pages/users/configuration_user.dart';

class RoutesNavBar extends StatelessWidget {
  final int index;
  final dynamic token;
  final String title; // Título del appBar

  const RoutesNavBar(
      {Key? key, required this.index, this.token, this.title = ''});

  @override
  Widget build(BuildContext context) {
    var decodedToken = JwtDecoder.decode(token);
    String userType = decodedToken['userType'];
    if (token.isNotEmpty && index == 0) {
      if (userType == 'Cliente') {
        return IndexUserPage(token: token);
      } else if (userType == 'Pyme') {
        return IndexPymePage(token: token);
      }
    } else if (index == 1) {
      return Map();
    } else if (index == 2) {
      return Activity();
    } else if (index == 3) {
      // return SettingsPage();
      return ConfigurationUserPage();
    }
    return Container();
  }
}
