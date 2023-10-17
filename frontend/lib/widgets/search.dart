import 'package:flutter/material.dart';

class UserSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  UserSearchBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          labelText: 'Buscas una pyme en particular?',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
