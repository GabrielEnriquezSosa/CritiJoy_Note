import 'package:flutter/material.dart';

class MenuItems {
  final String title;
  final Icon icon;
  final String link;

  MenuItems({required this.title, required this.icon, required this.link});
}

List appMenuItems = <MenuItems>[
  MenuItems(title: 'Inicio', icon: Icon(Icons.home), link: '/home'),
  MenuItems(title: 'Generos', icon: Icon(Icons.category), link: '/geners'),
  MenuItems(title: 'Personajes', icon: Icon(Icons.person), link: '/personajes'),
  MenuItems(title: 'Autores', icon: Icon(Icons.edit), link: '/autores'),
  MenuItems(title: 'Perfil', icon: Icon(Icons.account_circle), link: '/perfil'),
  MenuItems(
    title: 'Modo Oscuro',
    icon: Icon(Icons.dark_mode),
    link: '/modo_oscuro',
  ),
  MenuItems(
    title: 'Configuracion',
    icon: Icon(Icons.settings),
    link: '/configuracion',
  ),
  MenuItems(title: 'Salir', icon: Icon(Icons.exit_to_app), link: '/salir'),
];
