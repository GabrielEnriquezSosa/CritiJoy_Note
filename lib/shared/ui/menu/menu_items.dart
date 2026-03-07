import 'package:flutter/material.dart';

class MenuItems {
  final String title;
  final IconData icon;
  final String? link;
  final Function? onTap;

  MenuItems({required this.title, required this.icon, this.link, this.onTap});
}

List appMenuItems = <MenuItems>[
  MenuItems(title: 'Inicio', icon: Icons.home, link: '/home'),
  MenuItems(title: 'Autores', icon: Icons.group, link: '/autores'),
  MenuItems(title: 'Generos', icon: Icons.category, link: '/geners'),
  MenuItems(title: 'Analitica', icon: Icons.analytics, link: '/analytics'),
  MenuItems(title: 'Configuración', icon: Icons.settings, link: '/config'),
];
