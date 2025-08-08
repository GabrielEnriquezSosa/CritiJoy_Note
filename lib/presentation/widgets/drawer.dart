import 'package:critijoy_note/config/menu/menu_items.dart';
import 'package:critijoy_note/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationDrawerList extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const NavigationDrawerList({super.key, required this.scaffoldKey});

  @override
  State<NavigationDrawerList> createState() => _NavigationDrawerListState();
}

class _NavigationDrawerListState extends State<NavigationDrawerList> {
  int navDrawerIndex = 0;
  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).padding.top > 35;
    return NavigationDrawer(
      indicatorColor: Colors.lightBlueAccent,
      indicatorShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
        final menuitems = appMenuItems[value];
        context.push(menuitems.link);
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, hasNotch ? 0 : 20, 0, 0),
          child: Container(
            height: 138,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/anime.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                Text(
                  'Yazz',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
        ...appMenuItems
            .sublist(0, 4)
            .map(
              (item) => NavigationDrawerDestination(
                icon: item.icon,
                label: Text(item.title),
              ),
            ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 28, 10),
          child: Divider(color: Colors.black),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('Mas Opciones'),
        ),
        ...appMenuItems
            .sublist(4)
            .map(
              (item) => NavigationDrawerDestination(
                icon: item.icon,
                label: Text(item.title),
              ),
            ),
      ],
    );
  }
}
