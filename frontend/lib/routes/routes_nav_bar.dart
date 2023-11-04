import 'package:flutter/material.dart';
import 'package:proxi_pyme/pages/settings_page.dart';
import 'package:proxi_pyme/pages/index_page.dart';
import 'package:proxi_pyme/pages/map_page.dart';
import 'package:proxi_pyme/pages/activity_page.dart';

class RoutesNavBar extends StatelessWidget {
  final int index;
  final dynamic token;
  const RoutesNavBar({super.key, required this.index, this.token});

  @override
  Widget build(BuildContext context) {
    List<Widget> listaPaginas = [
      IndexPage(token: token),
      Map(),
      Activity(),
      SettingsPage()
    ];

    return listaPaginas[index];
  }
}
