import 'package:flutter/material.dart';

class MenuItems {
  final String title;
  final Icon icon;
  final String? link;
  final Function? onTap;

  MenuItems({required this.title, required this.icon, this.link, this.onTap});
}

List appMenuItems = <MenuItems>[
  MenuItems(title: 'Inicio', icon: Icon(Icons.home), link: '/home'),
  MenuItems(title: 'Generos', icon: Icon(Icons.category), link: '/geners'),
  MenuItems(title: 'Personajes', icon: Icon(Icons.person), link: '/personajes'),
  MenuItems(title: 'Autores', icon: Icon(Icons.edit), link: '/autores'),
  MenuItems(title: 'Perfil', icon: Icon(Icons.account_circle), link: '/perfil'),
  MenuItems(
    title: 'Configuracion',
    icon: Icon(Icons.settings),
    link: '/configuracion',
  ),
  MenuItems(title: 'Salir', icon: Icon(Icons.exit_to_app), link: '/salir'),
];
