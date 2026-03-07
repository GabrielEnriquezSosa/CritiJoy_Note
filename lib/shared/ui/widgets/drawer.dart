import 'dart:io';
import 'package:critijoy_note/shared/ui/menu/menu_items.dart';
import 'package:critijoy_note/shared/core/theme/app_theme.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:critijoy_note/features/auth/presentation/providers/auth_provider.dart';
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
    final user = ref.watch(authStateProvider);
    final userName = user?.name ?? 'Usuario';
    final userEmail = user?.email ?? '';
    final photoUrl = user?.photoUrl ?? '';

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Color.fromARGB(25, 245, 245, 240) : white,
        ),

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, hasNotch ? 50 : 30, 20, 20),
              width: double.infinity,
              color:
                  isDarkMode
                      ? const Color.fromARGB(255, 18, 87, 234)
                      : lightBlue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor:
                        isDarkMode
                            ? Colors.grey.shade600
                            : Colors.grey.shade800,

                    backgroundImage:
                        (photoUrl.isNotEmpty && File(photoUrl).existsSync())
                            ? FileImage(File(photoUrl))
                            : null,
                    child:
                        (photoUrl.isEmpty || !File(photoUrl).existsSync())
                            ? Icon(Icons.person, size: 36, color: white)
                            : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? white : darkBlue,
                    ),
                  ),
                  Text(
                    userEmail,
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
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
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
                              ? Colors.blue.withValues(alpha: 0.4)
                              : const Color(0xFFDCE9FB),
                      leading: Icon(
                        item.icon,
                        color:
                            isSelected
                                ? black
                                : (isDarkMode ? white : darkBlue),
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color:
                              isSelected
                                  ? black
                                  : (isDarkMode ? white : darkBlue),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          navDrawerIndex = index;
                        });
                        if (item.link != null) {
                          final String currentLocation =
                              GoRouterState.of(context).uri.toString();
                          if (currentLocation != item.link) {
                            context.push(item.link!);
                          }
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
                        ref
                            .read(isDarkModeProvider.notifier)
                            .toggleTheme(value);
                      },
                      activeThumbColor: blue,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
