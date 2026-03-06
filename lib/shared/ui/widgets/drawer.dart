import 'package:critijoy_note/shared/ui/menu/menu_items.dart';
import 'package:critijoy_note/shared/core/theme/app_theme.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavigationDrawerList extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const NavigationDrawerList({super.key, required this.scaffoldKey});

  @override
  ConsumerState<NavigationDrawerList> createState() =>
      _NavigationDrawerListState();
}

class _NavigationDrawerListState extends ConsumerState<NavigationDrawerList> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).padding.top > 35;
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 50 : 30, 20, 20),
            width: double.infinity,
            color: isDarkMode ? darkgrey : lightBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/anime.png'),
                ),
                const SizedBox(height: 12),
                Text(
                  'Jane Doe',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? white : darkBlue,
                  ),
                ),
                Text(
                  'jane.doe@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        isDarkMode
                            ? Colors.grey[400]
                            : darkBlue.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              itemCount: appMenuItems.length,
              itemBuilder: (context, index) {
                final item = appMenuItems[index];
                final isSelected = navDrawerIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    selected: isSelected,
                    selectedTileColor:
                        isDarkMode
                            ? Colors.blue.withValues(alpha: 0.2)
                            : const Color(0xFFDCE9FB),
                    leading: Icon(
                      item.icon,
                      color:
                          isSelected
                              ? darkBlue
                              : (isDarkMode ? white : darkBlue),
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color:
                            isSelected
                                ? darkBlue
                                : (isDarkMode ? white : darkBlue),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        navDrawerIndex = index;
                      });
                      if (item.link != null) {
                        context.push(item.link!);
                      }
                      widget.scaffoldKey.currentState?.closeDrawer();
                    },
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.dark_mode_outlined,
                    color: isDarkMode ? white : darkBlue,
                  ),
                  title: Text(
                    'Modo Oscuro',
                    style: TextStyle(color: isDarkMode ? white : darkBlue),
                  ),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      ref.read(isDarkModeProvider.notifier).toggleTheme(value);
                    },
                    activeThumbColor: darkBlue,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Salir',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    context.push('/salir');
                    widget.scaffoldKey.currentState?.closeDrawer();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
